Return-Path: <linux-btrfs+bounces-11450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAFA34C56
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 18:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9403A6E17
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4746D2222BF;
	Thu, 13 Feb 2025 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bdkh8W1h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948A202C44
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468827; cv=fail; b=vBK3uj2P/s8ucx2u6FdHCzuGCCJTJcGbT4RtOyqUnkKfVVeQUeXfK9l3M3lL6rVYiBdI3IYIE525c8MNqt0DW8NDXWRYhw3wAXAnm9v07hWY/XoRgOF4Mew2wkEw4uWFZwY+MXASyaWIKn2NsMwR2JIheXN7V8F6N5I47gcw8wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468827; c=relaxed/simple;
	bh=NsNziKFHa3bVy7ZMCxEhvwWnmlGH4lBErHN9NIYsPe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DW388f18+gnS8OPVGIzvjYI30Kn8G2zLGrvolsUbgofYY+9tGuiYUXBJ/14ZGQG2XuMG2Fk81QL4/NvTzrc6V2hIQlO5fqY8HAXN1bX4DnBcis9YRdmICLoTmYJ+//542gxq7w7sRfMj4DhozAN8o4Oue6sK8OwThYvN+oLZe2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bdkh8W1h; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DHSBH0005521
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 09:47:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=VHLGtUN65SkX6gEt+T1CzwGvIuNNtz/Yn01Snx8nvuU=; b=
	bdkh8W1hvSC6B2loVNMW/m4BEc0EKRmsNObY89mmaoJnDNOaKswmIb6DVsC6F2V9
	ud8jfhjC4BNQIWA29ZMZxOzZCl4wTtXH+xB31kFxcGqzBZ0XP/994rsD2Bo22C9A
	z08kwPeDsghYgRfGO+1uN/bt/r96rILcOIBbX8AL5s2N4KDEXpdWQ8DGeR2dW3qY
	t0gI9Y3i+8cXRx3eFImirtgSbqU4pwFbdbb8dp7CBOiGeUibDO8lnEz6QkVUoujI
	GT/OYX12ckrzoWfF33DUHAvryRyXmHd5SJ0tGIU7m+FUkuzQGuwarrHH+CUfzogY
	mNEttary5n3B1q1a6unqCg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44sg7waesk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 09:47:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbaS5GQyvc2kbevOqwYq9a0lnra1cKzWiPyfo2DfrUr5tnmZx5ERMlXmBj44On2r2eOVMpIaMWNPF2shDWHridFJLqVxE+O6JGzi8o7taeJvUNgSqdQ4ynH+ox0UgntmjjgQ/INTiABbwo5/yn8XOX7+e3cS8tDSoVShi/PImpo7dZqjb6dLjYx9B9/LqafnrR6Oz28OcD9VLX7nPbQcdVtGiNQ5UbfJMLp5X7+un9QSOb5Gu14y2ME6AEWf2LiTSbKs7P7jnrrJBCHy8FfbLRTpdg56AJD3uGtjM3yGnWpscM+4g+vCBq5NJrVM7azBkWL3b/3xvmJca9EORkduSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fYColcFKENvI9ZK3nOtcCKZ0l+nE7zNPlYh8R+BKcY=;
 b=PZ+XEZkKYonw3I0E7gNJqZHibaRRsuDejxpDlhQYAMq+ZMqR18curSAqDgy+Ab17WcJL6efjwBsi6NKpFXNO8kyep/6eckvxk5PlRQERlg5E5QPVjGcMl51xGYeVS05yjcm+d3gbg3HyNoh6UoI0txEXfLWQ2445PF++a6SATzXnrgxlgVGpoTho0E+RHbr6qVpItlCbhBxD/uXLJVwzPIiqmHVGqV7f9/qeGbpyLniDZ7N9BlNfKmYwaS18oRoyD3l91t76/ecNo11tkdIiSJMhCwnLYHVcykodbkDn/APMJU4V9/2i3FrBF3mpHwWkdZSfXXHsFxs7QEtHauLWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by CO6PR15MB4145.namprd15.prod.outlook.com (2603:10b6:5:34a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 17:47:00 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8422.021; Thu, 13 Feb 2025
 17:47:00 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: Boris Burkov <boris@bur.io>, Daniel Vacek <neelx@suse.com>,
        Filipe Manana
	<fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Topic: [PATCH] btrfs: use atomic64_t for free_objectid
Thread-Index:
 AQHbbMivsPcQp6znhUC74MzCCLPe17Miu8CAgAAUEQCAAhrjgIAArciAgABEL4CABQ9uAIAAK0GAgANRqwCAANNmgIACGYqAgAeQPYCACFgIAIAEZsUA
Date: Thu, 13 Feb 2025 17:47:00 +0000
Message-ID: <62d31fb6-27c7-48ba-9e0e-c9155ff5fe6f@meta.com>
References:
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz>
 <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
 <962f5499-d730-4e30-8956-7cac25a6b119@meta.com>
 <20250127201717.GT5777@twin.jikos.cz>
 <20250129225822.GA216421@zen.localdomain>
 <CAPjX3FfG9fpYWn-A8DROS9Kk3RTRj2RU+MP00gg7dCk=TF36Og@mail.gmail.com>
 <20250131193855.GA1197694@zen.localdomain>
 <4a42d804-ab7b-4734-a99f-c80ae354e93b@meta.com>
 <20250210223408.GS5777@suse.cz>
In-Reply-To: <20250210223408.GS5777@suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|CO6PR15MB4145:EE_
x-ms-office365-filtering-correlation-id: 770622f9-fb7e-4b2e-81c0-08dd4c566b57
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXZIdzNBMi90Y2d4N0tmMkxDN1lReGFvR1M0V1JIRHlKWWwzYUhrY0ZwTnVZ?=
 =?utf-8?B?YndHVXNVMGdwQ3BGZ0Qzd2E5Snh2YU9HL1QxdnNoODE5WFFSY2w2NCtQeHRC?=
 =?utf-8?B?REFnOVV1YUNoc0V1WDFrZ09YOUQyeXVIYVBOenNsNU01Y01lUGpobldoMkpt?=
 =?utf-8?B?eDRlOG5XdXpoYncrSXZuWUtXajNxWTVKbXk5a0lPRURwWm5tTjV1VmNOeXNp?=
 =?utf-8?B?Ym1NbHFqLzF4Y2pzUnY2emE5NGZ3RmtVZGh6UjRyU1FhZEx1aTRnbmJtRlli?=
 =?utf-8?B?YUsyL1cvWGZ5QVIwVDd3dStYdm5RaTRyRkpMc3dsbnk1SVBvYk5hKyt1dlVi?=
 =?utf-8?B?QTJPSS9PS3NSZC9yRmh1VnpPMStQbVhaU1pRU0luVDFTekJOcytObzJxYkdR?=
 =?utf-8?B?b1lBbnRzSFRhUGpqbVNSQ1RQNkFrYXBUUk1wYmRxMllpRSsyQ0pwM3ZIcmJi?=
 =?utf-8?B?V0J2R3QwcG9rV284MWhkUFV5WTlUMDFkeHZBd1h6MGZEMWNhcHRmanpXVVBD?=
 =?utf-8?B?bG45TmliOTcvK2Znbmc2YkY1TmxkNTlpeVRRYVBQV2M2L3dJVVRPVGZtTXo0?=
 =?utf-8?B?WkRvQmxXZHZMUkYyZmtsaG91K0R0bTVVL1F4ajZ5cTh2bVpDWGFNUFZuakND?=
 =?utf-8?B?N085dVdpTENLejU2Sm9OYkpLOVpvY2wzZUxlamZCNmRSM25ORWNXNjZVS25F?=
 =?utf-8?B?cTlBZW5OOXVudTBUSGN4WFhGZHF0OHh0OEZ3Q01ZWFpoMndRa2doSERNZmJr?=
 =?utf-8?B?NG1YRFFsOG5Vbnd0R09jWjcraEdqMkN3czdvdUhNblRQcXU4Qm9FRkR6aHlH?=
 =?utf-8?B?am10UHBRdFJWdU53aTk4d2grenJGbFBtQmQ2ZlBkcUZmcS9ITkFKemlDWVBN?=
 =?utf-8?B?STdQRGZHejBMclEvN1BOcFRaWW9GS3B2NzRMYllOQnIwclhwcDc0OWxZYXU4?=
 =?utf-8?B?OWhPa21sQVF3enk4bGc1MnJkMHpxdEp3aFMrc051T1RJc2xmZ1UvOGs1NFJ6?=
 =?utf-8?B?Q3JIdXpuakZUczNMZTQ2NHpaMlY1NTMwNGt6L2llUytXbFBZVHR5VTM4UDE5?=
 =?utf-8?B?THprL1hvaVBIOUhUcjl1N1FtdUZTRitBTEdpc0pyS0RrNVlvbTJkbHBBSk9r?=
 =?utf-8?B?eFBWS2ttZ2lHYWN0eW5QYXVQN28vb01HemtnRjRBNnNuNFN2NDVHQkh0aVZ6?=
 =?utf-8?B?OUZkTlBSM3ZyK1QxdERHT09acjA4OFlwSlJ2MlFXekZvT1RQRk1WWVltVFZH?=
 =?utf-8?B?UUF6eXU5TTF4c044WlJJRERaL0xocmRvM3hQM01qUVZxZTZnaHVuTE8rUmRt?=
 =?utf-8?B?MkdBeGRsdFhZMlRVOXR5SEZiNEhlemVXQldNZXA0VmpxcWluRWh5R0hXVXQ4?=
 =?utf-8?B?R1BocnJhWmk0YmdHR2NFdGs4SFJ0RWRuMlNyNTlyM2tGVDVqKzdxUzNjbHBT?=
 =?utf-8?B?TE5uSWh6QlNQUHhEY3g0OFUrWXdZbktKRUg2MU9rNlpnNFExOTdReWR6SS9Q?=
 =?utf-8?B?YlBxcURjeWMxckRzU2pFL1RBZXJ5aTZ6d3M2R2lheVdDVXZHRmkzeExqOXM2?=
 =?utf-8?B?VFI3RjNZTnFzSmVBSzFjZUNwRE5JMUpHVHVkNy9UTjlBbThIYytZalNPZEhw?=
 =?utf-8?B?K3Zrcnp6MDVpMkJTdlZFZ21vTFNZeEpiWk96ZklPck5QRnVzcmlRZjV6bXNh?=
 =?utf-8?B?U2pMRDNzR0pjbC9LT0UzdSsrZEhHSmszZitKeHpHN29jZjBWVEYxeXltWkdr?=
 =?utf-8?B?VDIvaHpQa252cEE2K2NUWFlNcXBxU3NHQStXL25XZ3NuTnRFbzRrd1NiL21o?=
 =?utf-8?B?TVlTWlJxVXpQMERqY0ZRMk9uZTUrdit2eFlQR045dHNNUzIrcXpGdHpTS3Vv?=
 =?utf-8?B?K3pNVm0rOUxsRUpRa3hpUzZvU1hHSUpYVnVjMzBYM3Bvb1hHUVJIQzl0ZVlK?=
 =?utf-8?Q?ukdMvacShTNE97+rc7H+ZgEVAIwPx8hQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXkrTExrcUsyeHJTVFNzdVJGTjUyUzBlM0IrdHQ0dmhrZ2I2SWpWajRhMlE3?=
 =?utf-8?B?WFpuSlU3V08wYVhkdGk2dUtHK0NLN2t0SVhScktiVWhWU1RVOGpUL0lxVWFp?=
 =?utf-8?B?V1VOdThIcUp1b1UzVlc5R2RkdVB2NHhmMWpueDA5Zll3K0p5czBId3V6Umpm?=
 =?utf-8?B?T0VmNzE3V3VCck1WamUyRCtvUmZHMWxFZUdCL2llWXhoMFVreFFqQ0hRUVFv?=
 =?utf-8?B?TkZudXZ0T0NRV0w4RGhESEJ4RXBxZnQwa1dIc1hha0psRUlEanZ4NHZ5SnhM?=
 =?utf-8?B?ZFNhMmpWUllOci83aE1XdU4vU2xsTXUycU1NNlNXbklNTVNnSTd1WiswL3Vj?=
 =?utf-8?B?SkcwQkxZZkx4aW1uejJHVmh0WXB4ZjRMUnh0dWJMcE1kK3BTTStMaWd5eThO?=
 =?utf-8?B?RHptZXJKNlhrc0Y0TjYzTUFWUjN2cU9VeHQzVGZkdVZuZW5yNi8ydjNrYUpP?=
 =?utf-8?B?OElqOEFrUUNpdENBU2dsMDNiRDN3RDNEUmhIQzdwYTBTdUswbFN5Q2U3SmlG?=
 =?utf-8?B?V2pEU2JLM016V3h4SDlMbGZOZnZjb3d2dmZlSVJHbDZ5SUtkWjUyenUwVmp5?=
 =?utf-8?B?b0VvSVJLZVpoazhiczBFdFo4NHVGUGU5OFZtUmwzalk2b2lUUlNobWoyQWcy?=
 =?utf-8?B?SHlEc05oWHJpeitoaWFhM1hvZjFUUnNUMWFsMlhWTWh3L0txWnh5YjI4akNF?=
 =?utf-8?B?ejFDWStTVzE0RnV1RDV0OWhnT1U3S3JsRjhBRFlCT2NDYmxvVTdxWktlaUdC?=
 =?utf-8?B?QTg5VTVmM09UNU9lazdxc1VWSHVlUUtLZTN5N2RYK2sxcER6Nm1xZGJqeVow?=
 =?utf-8?B?TzViZlk0VnBXNlBEdHJuMmZXdEpON1RtL3FEb240cVNBR0F4QjRETnA0dEE2?=
 =?utf-8?B?c3F3TENPKzNsdmFIQVdMeURlYTlsSEUwVlhkNkJ4TzJBbWl1MUtuWHYzYVdl?=
 =?utf-8?B?SWJ0ZUFLWURtTVoySEFheEl2NnRHcmF5bnlISTlvSUxBalE1M3h5Mk1DWkp6?=
 =?utf-8?B?TmlCVlNEN0t0RFhoMUQrWFFIZFRVbkFudk5vdC9CclROUndGMmhrd3hWRmpa?=
 =?utf-8?B?Uzd4NE12bW5jRExpV1J6b1VNSi9jK2RwdUhYeWtreHhHRmpJTTZZTWdLUnpM?=
 =?utf-8?B?d3lEd3FmWW9MeWhoMjd2Y0pRaE8yOHo3TEczS3B2WXNmV1g3S0wrL0prVmVK?=
 =?utf-8?B?ODdJb1ZZYzhqTy9GeHI5NFV6T0RuRzJXUWRFSXpUN2pFNCtvVkR3STI0eE44?=
 =?utf-8?B?bW0zUysxQ0hzcTZsT2lCL0VUWE41YStRQTJ0QWtCYThuZ1lRNUZXZ3crMzJD?=
 =?utf-8?B?QVdJV1JBU1pzMllINE9tWEFSRnhaL0o4alA3TFJOWFdZZGpoeHdTQ29xdEp2?=
 =?utf-8?B?bVhNSG5JOGFlYytDc3diQXdqeEdCSEVqRHdQQkRJOWcvR3VKZW9udHNnN3Z0?=
 =?utf-8?B?ZDJxQm41dTNydkNJdldoQ2htZ2lwd0o0VmtyOFFkdzJQaTQwenJudGlhLzVh?=
 =?utf-8?B?K0ZsNzdSZWw4OW1LYVVBaVZ5amhHOHlCSVcyVEJCcWVKSS9iQVFzcWtWc3BT?=
 =?utf-8?B?enZrT3dWRFFHem0zckM1UktpME8xS3h3RE1Bd1FXZFR0VG43bEx3ZFYxRTc4?=
 =?utf-8?B?NHBScldtU0RxRS9vUU53N09Gc1FDSllSQjVzLy9xRVVFeVRWeG1UNXM4bENa?=
 =?utf-8?B?dVN1Y2xnTXUwTVJSWXJ0MHJZbGZGQVdTV2tHNHcvck1peUJIMllzNmN5TVZZ?=
 =?utf-8?B?SVBxV1hYcWxLeHZyYXY2dVlkckN4eWRENzN4Ukd2WUoxblNydzhXTWI2ZVJn?=
 =?utf-8?B?bmFOL0ticzlITDVBelE2UzN6VWowek1wV0dyNFR0YXFveTg4U2RZVmVNNWdm?=
 =?utf-8?B?WVlPdC85bnFCY1NBTjJrcDhoL0RUb0tKNXN5MFVORHR6YTM5TU53d2c2SHhT?=
 =?utf-8?B?enQ4a0VaK1ZxS0RnNDVzSnk2OURpSE5OWmlod2hrTjZ1NkIxVDBFdWY2NW1B?=
 =?utf-8?B?QTIvbms2MG1seEVCdnA5VnRlUG9MSlJ3RHZScVJzUDZyeGZKZFNBU3J0Y1VH?=
 =?utf-8?B?dldsclkwVmVMdVpuRndrUlZOQkdkZnZoTDR1UW5WU1l0RUlrekdvZ1hvVlNq?=
 =?utf-8?B?ZkM4SDNoeVFRa0ZYUElQVGszbG5jYUFCdnZuMXNhQlA0Z0Fqa3d0UnRTcUk5?=
 =?utf-8?Q?IfYrG5jRnf2isCGnOrWesZo=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770622f9-fb7e-4b2e-81c0-08dd4c566b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 17:47:00.7745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wObpbrCTqzfoaNnYrIxhb/q0odgxlkZIjShco8Ge2eU7BE/fKXg4OELheVj8vT4b9GuJuV5MdQQJftXKncuxwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4145
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <FE430FCC088B8046A180FC696F3262D0@namprd15.prod.outlook.com>
X-Proofpoint-GUID: q_zzawsTmaQOHpuowHQkcQCNrsq0d3Dw
X-Proofpoint-ORIG-GUID: q_zzawsTmaQOHpuowHQkcQCNrsq0d3Dw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01

On 10/2/25 22:34, David Sterba wrote:
> >=20
> On Wed, Feb 05, 2025 at 03:08:59PM +0000, Mark Harmstone wrote:
>> On 31/1/25 19:38, Boris Burkov wrote:
>>> My understanding is that the motivation is to enable non-blocking mode
>>> for io_uring operations, but I'll let Mark reply in detail.
>>
>> That's right. io_uring operates in two passes: the first in non-blocking
>> mode, then if it receives EAGAIN again in a work thread in blocking mode.
>>
>> As part of my work to get btrfs receive to use io_uring, I want to add
>> an io_uring interface for subvol creation. There's two things preventing
>> a non-blocking version: this, and the fact we need a
>> btrfs_try_start_transaction() (which should be relatively straightforwar=
d).
>=20
>>>>>>> Even if we were to grab a new integer a billion
>>>>>>> times a second, it would take 584 years to wrap around.
>>>>>>
>>>>>> Good to know, but I would not use that as an argument.  This may hol=
d if
>>>>>> you predict based on contemporary hardware. New technologies can bri=
ng
>>>>>> an order of magnitude improvement, eg. like NVMe brought compared to=
 SSD
>>>>>> technology.
>>>>>
>>>>> I eagerly look forward to my 40GHz processor :)
>>>>
>>>> You never know about unexpected break-throughs. So fingers crossed.
>>>> Though I'd be surprised.
>>
>> More like 40THz, and somebody finding a way to increase the speed of
>> light... There's four or five orders of magnitude to go before 64-bit
>> wraparound would become a problem here.
>=20
> Thinking about the margins again, there is probably enough that we don't
> have to care. I'd still keep the upper limit check as for any random
> event like fuzzing, bitflips and such.
>=20
> The use case for nonblocking io_uring makes sense and justifies the
> optimization. As mentioned, there are other factors slowing down the
> inode creation and number allocation so it's "fingers crossed* safe.

Thanks David. Am I okay to push this patch to for-next then?

