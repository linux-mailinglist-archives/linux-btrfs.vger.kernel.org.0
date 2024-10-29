Return-Path: <linux-btrfs+bounces-9202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404119B465C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 11:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628881C223CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59777204034;
	Tue, 29 Oct 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XukQVnzi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E968187FE0;
	Tue, 29 Oct 2024 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196223; cv=fail; b=pnybGJhvVywoVMKczFMjsYlY4nMtMZejPhH/2AfKZVyDzIIrYwqEhqXX9ib7MmmYS0nmlD4f/3MwMXdKTPkkHloAcZWFYqfoa8xsWP8vl+5Evi/o5IEBNYQxifmcbbuaZXHBLL2gRpwiMiDHL5wB+aBDDdFRd5EJt9NowtTyU2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196223; c=relaxed/simple;
	bh=y/Q1Lfs42e7cS+WyppDkligkiW3oeC+uHC++LMzCrlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=brwrnEb/fZfcH5ElPEelQVt5gfudhqnRvEH14/o8aTYoYj2p5FRiR3MD9DZRGcTaNb6oqzJLqUt+mz9+C6b0/Fx1rjbgiWKnaIisRQkgqFS2IchCFwQ6KJUynsHWfEmakzv5jTgg1N4bDHx1geg+OoG9JZJcmxL07GkSwhS8/HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XukQVnzi; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T72IVA008346;
	Tue, 29 Oct 2024 03:03:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=y/Q1Lfs42e7cS+WyppDkligkiW3oeC+uHC++LMzCrlQ=; b=
	XukQVnziJolQmhNXYy7ieJZXvJMVB/XnlBzMHkkhDWK0BpeVmlJU0BcebgE6OJhV
	3v+NyQuZ/n62OuOE+KMFb5VLgbUKbh1GMnvA+CEc5FW58F4DB8JTlNrVSMRscCVL
	ZgPWFc2yrfGzFgeEBzmBJIvcSwD7vvJuIjA3zqhqptV4bUDmusfYW3hX5PzY/tLA
	chr86hFhaJFGQWbCDCyDfqLaLNxbJ/SLT5ODzq3zxTGPc3PsnhLl+/XXaWVWY/n1
	9bYlLqmOTYrW5Kz2EGD8sCddOYCuePNQiTJq5TTMP9cejhWsnZIgi8zp3PcA6gsk
	Ud1Dm42+ersG7wyT8wGd9Q==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jty50rsb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Oct 2024 03:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKO9KQtpkBe3caxJL+HZYVkNrh0W1PVAn8bn4c+7T4pZSOixgf2JlPTIzmJUUFiWOQt09MIgRqnUB7zXgBaT8SwHli4v1LsDqolFFtzpz0ZYNN2WZxYwdvepC9vjpQ06HfJ4eE8oRwOXP9+R3m5kPIp/nHqaEK9bZssxmsGyrVCULe6NMamAlSdSkPzrAP4szg1Pq6SwWQf6hQHAZ8BgFsHysnwn0hBJDWhUjplm6byp8UvJtedv3vQe42XiUfwJk4DUEN8qJAlpt6SMF43WB7ti5aUpzOLgaKbUPhGoDqIgUAh2eXLcaFVo0wjVxIc3R8DI9tnhm/ZNsHp4p2FtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Q1Lfs42e7cS+WyppDkligkiW3oeC+uHC++LMzCrlQ=;
 b=iQITIvPL2hG3TasZILNv/fUu5mQHs6yyCUCRgzCOEHLp+L8xTROlG/7wDRf/HEJTlgtsO7RR6G67KosrWnbNb6X1nuwzY8mNLF3NVwrM1yvT9TcVNM8Pt+Klsn19Uqjzdh8VF2VNbcw8vlpSdJ7V5EOcqD/OSDcdNPnBzUZblwdiPmcZk6/Xrw65/B/Q6hJ8lrcw+ivsSpcE+usplCRj/7Zoohv0cTYiiRNmEfJ1Wn6KmKPacQpn4B1KTF5WqCIfc69uql9jze3xYTzA2z33OrBMsIu2Agj8Khsn19aALaMjAGbvjSC2kn5eJ23NsLcC+jlDXMJOb1oj3sdLOQ9Z9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by BL3PR15MB5460.namprd15.prod.outlook.com (2603:10b6:208:3bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 10:03:36 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%6]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 10:03:36 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Zorro Lang <zlang@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Mark
 Harmstone <maharmstone@meta.com>,
        Filipe Manana <fdmanana@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Thread-Topic: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Thread-Index: AQHbHxiG5VfUS1reGUKSxW3KOmM4ibKcypEAgAB5UYCAAFGPgA==
Date: Tue, 29 Oct 2024 10:03:36 +0000
Message-ID: <bb0d612e-287b-4b5a-a56e-85c2d0a471df@meta.com>
References: <20241015153957.2099812-1-maharmstone@fb.com>
 <20241028215728.GU21840@frogsfrogsfrogs>
 <20241029051141.imqsprphzogzl7f5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To:
 <20241029051141.imqsprphzogzl7f5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|BL3PR15MB5460:EE_
x-ms-office365-filtering-correlation-id: 1410041c-62c3-4809-d3db-08dcf800f4a4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2dvZ3JRSkFMdFdNT0pla3NNTTZDNnZIOGxGWmVDZG1YQzl6UFhqdXVuQ21v?=
 =?utf-8?B?b210QjZJQVFvMHpua3VYcGtmbTNNWHJUWkNtMTVXakY5N2pyTUVoUWtVY3J3?=
 =?utf-8?B?dG9tZUhGMUxxeTRONTVlQXpqYUc0bUJVUGxDOHV2Mk94NGhqMmhWWHU0S3d4?=
 =?utf-8?B?MVJDS2hzWTFQQmRGYldhM2Y2T2NQays4cXRYeEF1UVpyU1BQemhwbVZyakd5?=
 =?utf-8?B?WjVPRTBCVWNZUGRhaDkxQ3hUZzI5ZTh4Y05USWVCYlZJU1pmNEd3eDZLWnRh?=
 =?utf-8?B?Nk83QVQxc1Y1MWNUaWFSWkVhNzJCZi9uZ08yMkdZS2hidDRUL2FGZUkyQzdT?=
 =?utf-8?B?dE1iZnlhRnMzT0hXVDU4U0xETFBRRG1HUStQRkhGUXdEd3BnUmdaR2l2Vldm?=
 =?utf-8?B?NWtSUjd5M2FFNGV1cVAxU2V1ZXI5VWNlVEpGaE9BZ2x2aGJFN0FvajcwOWVx?=
 =?utf-8?B?d0lTekRoNk5JamlBbWl2TUhOSHl4UDllZjdMUGg3QmFxMWVsZXNaUnJDLzgy?=
 =?utf-8?B?WmpxOU9kaHVrSWRDQlFacUtjOStIZkd2MzlXcmkydjNmV0NjSEp2blVORENj?=
 =?utf-8?B?VW9CcVJ0NGJSZlgxVUVVOVozaG90emliMTM4UEVOaW5kVFBQL2s1cEg5cmpt?=
 =?utf-8?B?d2trS1RSRkJaUk5DOUZNV1BDS05acWZNbmdaRWZkZklHNjdKMXFOYUxzM0p1?=
 =?utf-8?B?S3k3NDRMSVZEcGlVcUsvZVViN3JHVkUwZ0puVVloSVNjTzdWT1RKTGhSUlF0?=
 =?utf-8?B?VC9ib1ZTanI0dnR0S3NXZHY2SGZJMUtSblh3bmFIYTZqN1NQaUtnbGpxRHJq?=
 =?utf-8?B?eTU2UlVXU05oUU5KdmRCejJRUHcvUFY5Tmpad28xdlNlZnVoRVZPV3ZlL2cz?=
 =?utf-8?B?RzJxVDhZdjYzWi81cktpQkZOU1pSZGxWZm5TYTNsNHl5Zit6ZDFWSEZRNzRL?=
 =?utf-8?B?MlF4ZmFidk1OcWxrZVQwVmxTdTZ0NnVmbEN6ZVczem1HcG1TNkxRMWdvUFc5?=
 =?utf-8?B?ZTlwSjV1NUFqYVZDZ0JXQ2RBekJSeU8yTU1WTmVOUTlSMHlyZng4Z3Z6eDJU?=
 =?utf-8?B?ZytFK2QzY3JHdUl2VzJmOVE5d1RDUkExVDdlM2dtYU1yUXQ3UndZY0RxWEFp?=
 =?utf-8?B?Z1I1RjlMMWlTU1VwUVNaWXJlWVYwSmRZcmNsLzVydno1OTFuMmJRWWcvK2FI?=
 =?utf-8?B?L0RtQXE3alZUd0dXQ3ZQZmczMFdjR3ZaTVQxZFM1L3lmbXBMYzhlRFBkRStD?=
 =?utf-8?B?K0dZbHJjRnFLUEY3a2w5VzZvMjBaVjNkcUlHUWo5dlFSR3lnRFovdDBRb1NK?=
 =?utf-8?B?NVBMVGUzc0l4bTJoRHdJdk9pU0xhQTR1Rk4rdlh6UUdhQ29LU052NENhRWU4?=
 =?utf-8?B?Qk42eUdqOUs5UGpOTm5xNTlwTG5kc0RPeWZkV2lGMDc5Nmw2UVNpbDh0Q1R1?=
 =?utf-8?B?VmNISFZYWnBneDgxUldKYzdTdXdacjJEQXFzVU1CMEZDeXFwTlhScWZ1ZXRL?=
 =?utf-8?B?cmF2ZUJRRkZzVHNzN0l0NmVqRW1iR0VxTG9nMkdTN0FWbHhId2Z1eWJpTnZX?=
 =?utf-8?B?cE5CYmVDMzlNZHM0T3BWSU1tRC9CQkwwcHFrL2gvaWpxcW95WGpYY1VRZHBJ?=
 =?utf-8?B?RnA4cVJTV1IvTDhNUVpzSytlR0hvMnExVUErOUpzK001UWZ5dXhhL2tnbEtP?=
 =?utf-8?B?Mzl4MG1hMVNEVXhDbWwwTmFray9QUitiZmkrRnA2bnYxemtXWFhBUUNzYkRr?=
 =?utf-8?B?VGdHNEJpUUM2ZnJBVEJaR1dVN2xwMU1KeFlZTTZvU0FMZW16d2hpUFNId29I?=
 =?utf-8?Q?nCwrasMC9JbHGL8vcRn39LjwPA4nKB/ZPLVn8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blljZ0M4SXNjbkFIczQyQ0hpNjg4aHJaMDRydHM2eCsvb3ZBOW9Tei8wSEw2?=
 =?utf-8?B?OUpwMkZKWmkzR05vOXc0U1BSeUNVbTZmbjlDV01hTldSZGNscDd4bC83R1Z2?=
 =?utf-8?B?KzRnWE9MSkd0aktUeTFDc0VGVHYvWktqWjNTV00yRzdPQ29BKzd4NVRNdHlq?=
 =?utf-8?B?K2hoSHlUeitSbmpTNGFtK0dCdjVCWTVTUUJrNEZqaWtVVXdHSUlzSm40czl3?=
 =?utf-8?B?MWFoNjJETEtTb1poY1VyLzVwemFTZ3ZvRXhtamQ3MGMwNzFFb3RTYjZSQ0Np?=
 =?utf-8?B?b3FWcGwxcTQ0MlV0VjVJSkRLYmtqeWQwbkoxbDlMQW5DenRObXl5c1NQc1Fw?=
 =?utf-8?B?akprRGNOb0lnZ2tzVzhTaDc1YmFvb01CR3VsbUdxZTBlQnQxek91UUQ4RFhP?=
 =?utf-8?B?eTluVzhZaG5Xd2xibndSc1RIblhzTGhxVC9tZ3hUK09CK0VxVzBZUlBVNXFk?=
 =?utf-8?B?UGkxb1NXWmxQTDBCOGVhZU1EKy9Ob1ZxS0ZPekVFR1RBWVRVRENxdURpTlIz?=
 =?utf-8?B?RHhoU2lHZ3EvMXUyaTlQbG53Z04ybkkzUGJNLzRKVDJmQ2VwOTlJQkZwNnE0?=
 =?utf-8?B?M0RuMEJQSFplVjkvZXp3OHNEeGZLYkNmekNYaERabDEyVXd5a3BidFpPMGg4?=
 =?utf-8?B?RXJmdjRSc0U5TkZUVzRoRXV4ZmhMRExSbkIvSXk5VUVKblZ1Z2paZUhMTm5m?=
 =?utf-8?B?Y0ZFV3k2a29CRzk3QVU4OFJzdElDYlFsUGxVQU80a0pHZmJSKzYrdU5LVXJa?=
 =?utf-8?B?dTc2WWc3c2F6c3lyNkdjVlI2K0RxU1ovZVFWYWNHOWhqR0dVWEhoc3ZQM0sv?=
 =?utf-8?B?anNlOWU0S3o4NlUvcGpTSThaRU9EdllTSnJMK2dMYk1qYmtIaG15elVVazFl?=
 =?utf-8?B?YjdqSzM4ekRiSWwwcnJuQnYyWDF3K0JHOXRSNFVxeis0R044Y3pqa3RNeGht?=
 =?utf-8?B?QzhsY2ZzeFJ6d1RFT3hzSjJyM25oMEVDNmd3R0REZzRzd1ZkUXZzR0g3REg0?=
 =?utf-8?B?N0JGMjZpTEhPcTArbFVYNU9XajZta2NURW9VVzhYamV3cGZhTGdjbUF6aW04?=
 =?utf-8?B?SzFFb1BhMXlZTXNFYUZNNDFDVC9PUWI4TEY3bExEaUFmRG1CdGQvaDJvY2Rw?=
 =?utf-8?B?MHlCbDVOdFMzN2oxd2QyNndtZVA3TDQ3YUVoQnZNT3BoeUxrcnBuZTJoSGtK?=
 =?utf-8?B?TGFUcGpVV1k4bGh3TDV6MndmNGJ2UlZPN3VHcnVFTERZTlBCZjR6OVRQYU95?=
 =?utf-8?B?RDVSaGVjc3Z1cVh3MU0yc21Wc2R2YnhkZ1B6RitaYVJyZDdyOTgvWmJ4U0th?=
 =?utf-8?B?WHVKbStoZ2c3QnUrMWNDWGNjWFFyQ3k0QklNOHlDWVZEZkFoSzMvaFdISFk1?=
 =?utf-8?B?cEx4WkY0NEU1OTZBK2hIOUxWNEEzOW5UZWk0WFBzUlc1WGhmNjR4YWFUUy92?=
 =?utf-8?B?ZmJkRmlpWHo1QUVZS3BkSUZsU2JCaDJtTFA0Y0hKN3hmZ0xINlpGQXhUZEdO?=
 =?utf-8?B?YmEzQUtxMDR2VVcwNkoxUWlHZVVrdU5zU2dQRENMNWpKZjRzRXo4OURCNldu?=
 =?utf-8?B?bHF6ZDNtZVFWSGdVWHQ2eXJzMEM1TGFvaVFZM25ZWmJmK3BNTWhQNVBwQU8z?=
 =?utf-8?B?UzhkTnUzSTU0eDlrcDJlbTZjYzdwclA0UTRkQUo5U25PK1liVW9jNkYyUDZn?=
 =?utf-8?B?d2V3WHBTeFIwYVJnTGwyekczV0J2VXh0ajh1eTZZMjZTY1RUbkx1aVBNWFA5?=
 =?utf-8?B?SlpHN01pcldRZHJzd0NyY3djNGtoYlozN3h3aWkvSnlGK3kxUVh4UkpoWlgv?=
 =?utf-8?B?T0ZTb0hTTXBEdHNMYXZEcHNRbjA3RWt0VkZENU9PTHRRcHJ2Z0xvQ1JVUnJr?=
 =?utf-8?B?NEtmeW1qRFZQQkRnRGtadDc3M01iZVR2S0ZDcmJrVEFZV0orVW5jTkQyMll0?=
 =?utf-8?B?MWphczhvM0FzS29WUWZ3aVdLU1FydFNvaFdXckd4M1RFMW4rQU01WHdzWVYy?=
 =?utf-8?B?cGQ3bXFlVWNRdFJXWW5XTkdjSlZldzNTT0JlQjZiWHFqTHhZdW9CS2QyT004?=
 =?utf-8?B?WEc4dnplY3EvcERuRE9sN3dGc0xHMXBlK1dBM1daWVFqaVpqQWdUMUN0ckl6?=
 =?utf-8?B?SE4wSGlwQjJCUTN0WnN3Qy9Pd21WZTMrZkxzS1d4TUxRQzQvQ3gvdHdZVXlZ?=
 =?utf-8?Q?mvpwzrKNAEEH794/mhGwv74=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFEB2C6B0CCF9049AFA6E856090983E7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1410041c-62c3-4809-d3db-08dcf800f4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 10:03:36.7879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCELyJFDMss1ZzYZ8hO0YzGotFCNEwyVYRVUvceXY7OJGB6vsTKb8h0bwPd4BIXrjncI6xIQOhziOyFRuqPtKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5460
X-Proofpoint-ORIG-GUID: wELZkUMAczcSfXBwS59tqEDvzzWvY8li
X-Proofpoint-GUID: wELZkUMAczcSfXBwS59tqEDvzzWvY8li
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

T24gMjkvMTAvMjQgMDU6MTEsIFpvcnJvIExhbmcgd3JvdGU6DQo+IE9uIE1vbiwgT2N0IDI4LCAy
MDI0IGF0IDAyOjU3OjI4UE0gLTA3MDAsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4+IE9uIFR1
ZSwgT2N0IDE1LCAyMDI0IGF0IDA0OjM5OjM0UE0gKzAxMDAsIE1hcmsgSGFybXN0b25lIHdyb3Rl
Og0KPj4+IEFkZHMgYSB0ZXN0IGZvciBhIGJ1ZyB3ZSBlbmNvdW50ZXJlZCBvbiBMaW51eCA2LjQg
b24gYWFyY2g2NCwgd2hlcmUgYQ0KPj4+IHJhY2UgY291bGQgbWVhbiB0aGF0IGNzdW1zIHdlcmVu
J3QgZ2V0dGluZyB3cml0dGVuIHRvIHRoZSBsb2cgdHJlZSwNCj4+PiBsZWFkaW5nIHRvIGNvcnJ1
cHRpb24gd2hlbiBpdCB3YXMgcmVwbGF5ZWQuDQo+Pj4NCj4+PiBUaGUgcGF0Y2hlcyB0byBkZXRl
Y3QgbG9nIHRoaXMgdHJlZSBjb3JydXB0aW9uIGFyZSBpbiBidHJmcy1wcm9ncyA2LjExLg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWFyayBIYXJtc3RvbmUgPG1haGFybXN0b25lQGZiLmNvbT4N
Cj4+PiAtLS0NCj4+PiBUaGlzIGlzIGEgZ2VuZXJpY2l6ZWQgdmVyc2lvbiBvZiB0aGUgdGVzdCBJ
IG9yaWdpbmFsbHkgcHJvcG9zZWQgYXMNCj4+PiBidHJmcy8zMzMuDQo+Pj4NCj4+PiAgIHRlc3Rz
L2dlbmVyaWMvNzU3ICAgICB8IDcxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+PiAgIHRlc3RzL2dlbmVyaWMvNzU3Lm91dCB8ICAyICsrDQo+Pj4gICAyIGZp
bGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykNCj4+PiAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0
ZXN0cy9nZW5lcmljLzc1Nw0KPj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2dlbmVyaWMv
NzU3Lm91dA0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNzU3IGIvdGVzdHMv
Z2VuZXJpYy83NTcNCj4+PiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPj4+IGluZGV4IDAwMDAwMDAw
Li42YWQzZDAxZQ0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi90ZXN0cy9nZW5lcmljLzc1
Nw0KPj4+IEBAIC0wLDAgKzEsNzEgQEANCj4+PiArIyEgL2Jpbi9iYXNoDQo+Pj4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+PiArIw0KPj4+ICsjIEZTIFFBIFRlc3QgNzU3
DQo+Pj4gKyMNCj4+PiArIyBUZXN0IGFzeW5jIGRpbyB3aXRoIGZzeW5jIHRvIHRlc3QgYSBidHJm
cyBidWcgd2hlcmUgYSByYWNlIG1lYW50IHRoYXQgY3N1bXMNCj4+PiArIyB3ZXJlbid0IGdldHRp
bmcgd3JpdHRlbiB0byB0aGUgbG9nIHRyZWUsIGNhdXNpbmcgY29ycnVwdGlvbnMgb24gcmVtb3Vu
dC4NCj4+PiArIyBUaGlzIGNhbiBiZSBzZWVuIG9uIHN1YnBhZ2UgRlNlcyBvbiBMaW51eCA2LjQu
DQo+Pj4gKyMNCj4+PiArLiAuL2NvbW1vbi9wcmVhbWJsZQ0KPj4+ICtfYmVnaW5fZnN0ZXN0IGF1
dG8gcXVpY2sgbWV0YWRhdGEgbG9nIHJlY292ZXJ5bG9vcA0KPj4+ICsNCj4+PiArX2ZpeGVkX2J5
X2tlcm5lbF9jb21taXQgZTkxN2ZmNTZjOGU3IFwNCj4+PiArCSJidHJmczogZGV0ZXJtaW5lIHN5
bmNocm9ub3VzIHdyaXRlcnMgZnJvbSBiaW8gb3Igd3JpdGViYWNrIGNvbnRyb2wiDQo+Pj4gKw0K
Pj4+ICtmaW9fY29uZmlnPSR0bXAuZmlvDQo+Pj4gKw0KPj4+ICsuIC4vY29tbW9uL2RtbG9nd3Jp
dGVzDQo+Pj4gKw0KPj4+ICtfcmVxdWlyZV9zY3JhdGNoDQo+Pj4gK19yZXF1aXJlX2xvZ193cml0
ZXMNCj4+PiArDQo+Pj4gK2NhdCA+JGZpb19jb25maWcgPDxFT0YNCj4+PiArW2dsb2JhbF0NCj4+
PiAraW9kZXB0aD0xMjgNCj4+PiArZGlyZWN0PTENCj4+PiAraW9lbmdpbmU9bGliYWlvDQo+Pj4g
K3J3PXJhbmR3cml0ZQ0KPj4+ICtydW50aW1lPTFzDQo+Pj4gK1tqb2IwXQ0KPj4+ICtydz1yYW5k
d3JpdGUNCj4+PiArZmlsZW5hbWU9JFNDUkFUQ0hfTU5UL2ZpbGUNCj4+PiArc2l6ZT0xZw0KPj4+
ICtmZGF0YXN5bmM9MQ0KPj4+ICtFT0YNCj4+PiArDQo+Pj4gK19yZXF1aXJlX2ZpbyAkZmlvX2Nv
bmZpZw0KPj4+ICsNCj4+PiArY2F0ICRmaW9fY29uZmlnID4+ICRzZXFyZXMuZnVsbA0KPj4+ICsN
Cj4+PiArX2xvZ193cml0ZXNfaW5pdCAkU0NSQVRDSF9ERVYNCj4+PiArX2xvZ193cml0ZXNfbWtm
cyA+PiAkc2VxcmVzLmZ1bGwgMj4mMQ0KPj4+ICtfbG9nX3dyaXRlc19tYXJrIG1rZnMNCj4+PiAr
DQo+Pj4gK19sb2dfd3JpdGVzX21vdW50DQo+Pj4gKw0KPj4+ICskRklPX1BST0cgJGZpb19jb25m
aWcgPiAvZGV2L251bGwgMj4mMQ0KPj4+ICtfbG9nX3dyaXRlc191bm1vdW50DQo+Pj4gKw0KPj4+
ICtfbG9nX3dyaXRlc19yZW1vdmUNCj4+PiArDQo+Pj4gK3ByZXY9JChfbG9nX3dyaXRlc19tYXJr
X3RvX2VudHJ5X251bWJlciBta2ZzKQ0KPj4+ICtbIC16ICIkcHJldiIgXSAmJiBfZmFpbCAiZmFp
bGVkIHRvIGxvY2F0ZSBlbnRyeSBtYXJrICdta2ZzJyINCj4+PiArY3VyPSQoX2xvZ193cml0ZXNf
ZmluZF9uZXh0X2Z1YSAkcHJldikNCj4+PiArWyAteiAiJGN1ciIgXSAmJiBfZmFpbCAiZmFpbGVk
IHRvIGxvY2F0ZSBuZXh0IEZVQSB3cml0ZSINCj4+PiArDQo+Pj4gK3doaWxlIFsgISAteiAiJGN1
ciIgXTsgZG8NCj4+PiArCV9sb2dfd3JpdGVzX3JlcGxheV9sb2dfcmFuZ2UgJGN1ciAkU0NSQVRD
SF9ERVYgPj4gJHNlcXJlcy5mdWxsDQo+Pj4gKw0KPj4+ICsJX2NoZWNrX3NjcmF0Y2hfZnMNCj4+
DQo+PiBUaGlzIHRlc3QgZmFpbHMgb24geGZzIGJlY2F1c2UgKGFmYWljdCkgcmVwbGF5aW5nIHRo
ZSBsb2cgdG8gJGN1cg0KPj4gcmVzdWx0cyBpbiAkU0NSQVRDSF9ERVYgYmVpbmcgYSBmaWxlc3lz
dGVtIHdpdGggYSBkaXJ0eSBsb2c7IGFuZA0KPj4geGZzX3JlcGFpciBmYWlscyB3aGVuIGl0IGlz
IGdpdmVuIGEgZmlsZXN5c3RlbSB3aXRoIGEgZGlydHkgbG9nLg0KPj4NCj4+IEkgdGhlbiBmaXhl
ZCB0aGUgdGVzdCB0byBtb3VudCBhbmQgdW5tb3VudCB0aGUgZmlsZXN5c3RlbSB0byByZWNvdmVy
eQ0KPj4gdGhlIGRpcnR5IGxvZyBiZWZvcmUgaW52b2tpbmcgeGZzX3JlcGFpcjoNCj4+DQo+PiAJ
IyB4ZnNfcmVwYWlyIHdvbid0IHJ1biBpZiB0aGUgbG9nIGlzIGRpcnR5DQo+PiAJaWYgWyAkRlNU
WVAgPSAieGZzIiBdOyB0aGVuDQo+PiAJCV9zY3JhdGNoX21vdW50DQo+PiAJCV9zY3JhdGNoX3Vu
bW91bnQNCj4+IAlmaQ0KPiANCj4gVGhhbmtzIERhcnJpY2ssIHlvdSdyZSByaWdodC4NCj4gSSdt
IHdvbmRlcmluZyBjYW4gd2UgYWx3YXlzIGRvIGEgbW91bnQmdW5tb3VudCBhdCBoZXJlLCBubyBt
YXR0ZXIgdGhlDQo+ICRGU1RZUCwgaWYgdGhhdCBkb2Vzbid0IGFmZmVjdCB0aGUgdGVzdGluZyBv
ZiBvdGhlciBmaWxlc3lzdGVtcz8NCj4gDQo+PiAJX2NoZWNrX3NjcmF0Y2hfZnMNCj4+DQo+PiBC
dXQgbm93IHRoZSB0ZXN0IHRha2VzIGEgdmVyeSBsb25nIHRpbWUgdG8gcnVuIGJlY2F1c2UgKG9u
IG15IHN5c3RlbQ0KPj4gYW55d2F5KSB0aGUgZmlvIHJ1biBjYW4gaW5pdGlhdGUgMTcsMDAwIEZV
QXMsIHdoaWNoIG1lYW5zIHRoYXQgdGhpcyBsb29wDQo+PiBydW5zIHRoYXQgbWFueSB0aW1lcy4g
IDEwMCBpdGVyYXRpb25zIHRha2VzIGFib3V0IDQ1IHNlY29uZHMsIHdoaWNoIGlzDQo+PiBhYm91
dCB0d28gaG91cnMuDQo+Pg0KPj4gSXMgaXQgbmVjZXNzYXJ5IHRvIGl0ZXJhdGUgdGhlIGxvb3Ag
dGhhdCBtYW55IHRpbWVzIHRvIHJlcHJvZHVjZQ0KPj4gd2hhdGV2ZXIgaXNzdWUgYnRyZnMgaGFk
Pw0KPiANCj4gWWVzLCBpdCB0YWtlcyBtdWNoIGxvbmcgdGltZSBvbiBteSBzaWRlIHRvbzoNCj4g
ICBGU1RZUCAgICAgICAgIC0tIGV4dDQNCj4gICBQTEFURk9STSAgICAgIC0tIExpbnV4L3g4Nl82
NCBkZWxsLXBlcjc1MC00NyA2LjEyLjAtcmM0KyAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSBP
Y3QgMjUgMTQ6MjU6NDUgRURUIDIwMjQNCj4gICBNS0ZTX09QVElPTlMgIC0tIC1GIC9kZXYvc2Rh
NA0KPiAgIE1PVU5UX09QVElPTlMgLS0gLW8gYWNsLHVzZXJfeGF0dHIgLW8gY29udGV4dD1zeXN0
ZW1fdTpvYmplY3Rfcjpyb290X3Q6czAgL2Rldi9zZGE0IC9tbnQveGZzdGVzdHMvc2NyYXRjaA0K
PiANCj4gICBnZW5lcmljLzc1NyAgICAgICAgNDI0N3MNCj4gICBSYW46IGdlbmVyaWMvNzU3DQo+
ICAgUGFzc2VkIGFsbCAxIHRlc3RzDQo+IA0KPiBTbyBiZXR0ZXIgdG8gcmVkdWNlIHRoZSB0ZXN0
aW5nIHRpbWUgYXMgbXVjaCBhcyBwb3NzaWJsZSwgYW5kIHJlbW92ZSBpdA0KPiBmcm9tIHRoZSAi
cXVpY2siIGdyb3VwLiAoTWF5YmUgd2UgY2FuIGhhdmUgYSB0YWcgdG8gbWFyayB0aG9zZSBjYXNl
cyBuZWVkDQo+IG11Y2ggbG9uZyB0aW1lIHRvbykuDQoNCk9yIG1heWJlIGl0IHNob3VsZCBiZSBt
YWRlIGJ0cmZzLXNwZWNpZmljIGFnYWluPyBUaGF0J3MgaG93IEkgb3JpZ2luYWxseSANCndyb3Rl
IGl0LCBidXQgRmlsaXBlIE1hbmFuYSB0aG91Z2h0IGl0IG91Z2h0IHRvIGJlIGdlbmVyaWNpemVk
Lg0KDQpBbiBhZHZhbnRhZ2Ugb2YgbWFraW5nIGl0IEZTLXNwZWNpZmljIGlzIHRoYXQgeW91IGNh
biB1c2UgdGhlIC0tZnNjayANCm9wdGlvbiBpbiBsb2ctd3JpdGVzLCB3aGljaCBpcyBhYm91dCAx
MCB0aW1lcyBxdWlja2VyIHRoYW4gZG9pbmcgdGhlIA0KbG9vcCBpbiBiYXNoLg0KDQpNYXJrDQo=

