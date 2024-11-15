Return-Path: <linux-btrfs+bounces-9727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE29CF09D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 16:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134751F2909E
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650E1D9A56;
	Fri, 15 Nov 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jRCSafaO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A11D90DD
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685438; cv=fail; b=r1g3xHUSVnLUneQTiKqHg/BBr9aZ01Sxfdr+Fycx5ZcqGedfaVmNZJejodL2wRxqIsLZVDbAVB4wuo3tsWw9ZRnoiy9KqxWUl8+06UEt3LnuATuvBuoXgW3mKtIcXIt2VYWM00sDZ7Nl6+EE+kk7l6OAjUMkUcefLgEBKGFBVUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685438; c=relaxed/simple;
	bh=3WLGz477sAyP6YhGatICHzTIW1xMQOF0Sn3XP/tyXzo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=AdSsoWHwtQk+ECi2oUHglJqrMTGWN/BH82R6fi7I6G7mEX+6/E+u0prfOf8cLrRy2Q+TKZAe39NWtvQ7d0L0vW/YdfJmHmb56doSLvy2VVVgz2le734RFdvOzE8YZ5DBTq7zClgSp/EVmFJvBA9O1nNc2jHg9s2BJWIMYZj72TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jRCSafaO; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4AFEMfHV004325
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:43:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=yd+ysUJ/3TEcA+ofbv06gay+q36Ba1v2eDsNIb17KxE=; b=
	jRCSafaOuxtow2zmiMbVzMhRwiv33YutR8chmhBAuN98WS1JaLRp4cme7JuVlp++
	syL31ey7Y0VCx26pLjJT6H0zb+NNxNZtILFSbpOp+Yxfi9n1lfbL8QrQkNU4WH/j
	IVUdLf3lLFb7QLfqomphLSV6+Aoh8yWCMdAAxa9JlMBKo9aJbwjv7FNxx4d1k3ef
	ztv5+5vA9+UcAkYtBJGXwbL1N7anwunwvQ2/0EFJDFVCw2opx06tjRWJMS1nBqJw
	yCmR/ajdyoFLr1gdb7Cp67DVvvLj72pdf4CyOmvpnugiMXc03z3sbSmQQpnCjxnM
	GR2MRMojfcJAGSkilWzQqg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by m0001303.ppops.net (PPS) with ESMTPS id 42x4pkhrvw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 07:43:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/Z6h4i/wzP8M3ucZLnA01RycXDXeCy+A7jE8itNfTUB2vIQiupUnu1zgAZhh4U/tNk7LnzwKt+o9Pf/E/3LB5i7UEWF3eBixVohHq5NKAZZJkbmBaFvvHeKt+G+TQaLd8f7EXoFIFzU3H8S0lSL/ormoUqP2HvaFj7jYDpio3r62CtB03tFBYqhgsFvm9Zv5f5+4hLDmu1ln6lBtuXCBFZH9IIFwPtDjgzvjwGaN1LEqjT1NNDBztHzjGx5L/QypceJXsVX0+9cn2uRfZ+JcLqH0JXXbqO+XVTY+ww4ElTGK+Vgk88iRUcOt3D9WArwxD6PRFM4ndrP635e6hGihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6pWoTyF5V+T4JsI+OAYCERbsFrUI9XUAaNt+tREtXQ=;
 b=IuK+hBDxHZsAwaouZvcoOo/4x/cTmpyktYgaqTSRX6jaKygE0jwhTd0NzwNYWAFYb88L6tsuXUKQQP1tsT1S0RUCa3UfBCPh2S/n3WufOygSjhSorxiXmbxYYZpUZX6TDVx/JuIXqpp/gNR4VAvxfK0zdahFMmG8lxuvPLwNXUJWdeMY+ntNUzDF4qNpP/sIjAdd++PLqKpVnkiABq0JFOuLrYBmTFqfBBxWG4eD2V1eyFBxKrWHADir/y45sxbxoSfrIHEyKCNz0COA54jqBic/WebXW4NszmDTg1PLRemr3/bgj2N6nT7/Rww7SxT57eKaqyiRKiOV7gVLrEQmIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH7PR15MB5426.namprd15.prod.outlook.com (2603:10b6:510:1fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 15:43:51 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 15:43:51 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes
 Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Topic: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Thread-Index: AQHbNRwWDaKzGcsc4kWOxTgKfQv67LK241kAgAGcwwA=
Date: Fri, 15 Nov 2024 15:43:51 +0000
Message-ID: <d3be0f1b-ee2b-4372-9dac-c3d630dcb6cf@meta.com>
References: <20241112160055.1829361-1-maharmstone@fb.com>
 <20241114150630.GT31418@twin.jikos.cz>
In-Reply-To: <20241114150630.GT31418@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH7PR15MB5426:EE_
x-ms-office365-filtering-correlation-id: 87d64d72-be37-46cf-dd0c-08dd058c4da7
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjlkZ0dEZk0zVFkrQWhVS3A2UGpQUkM1WmlCQWtTdXAyN2g1SFVOdVlPSEI0?=
 =?utf-8?B?Ti9jMy9WY1BuVUU1Ull1WlBVWWJpc2hNbC93aXh0Wi9qTjhELzZiY3hISmhi?=
 =?utf-8?B?LzJiZTlCRnBCVmdtNlhqSytZNTZMc0RWWENtazFNRFZtZUNsTHZMRTR4dFJQ?=
 =?utf-8?B?UGJ2U1JpSXp4c21GM0JpK1JwVDJCWjdkbHZUTWJxa1BZSm52YURWbkhudDZa?=
 =?utf-8?B?bDJxUW5ISHVXVmY5WWxkUXB1TGsvRTA4YXh3ZXlkU3hGQlVadW5paXhTWHF2?=
 =?utf-8?B?MHNCcEFFRDNTS0xDWDZ2YzZLeEREeWZ0S3BrSFJCbXA1YkJDcGtEV2tnaXNW?=
 =?utf-8?B?RElHa3RFakZobXhCeUtOY2NnVnh3ek55VzVwWGFWNzBrMVpWaG1iWXYzMmdQ?=
 =?utf-8?B?RkhjTEpQQndUL1o5VWRjNGIvMks3MGdTcFZSbXN5Tm0wcjN6OXQyR1NMeU9q?=
 =?utf-8?B?OEhnRWhSTFlUN2RvVnhyejdGNUF5RS9ndGFYbHFiQzhMeXVZWFVDVCtGc1JO?=
 =?utf-8?B?YXR0UFlmZWpPVlJoRG42RzVCcjc0aUtLTktlR0UxbUQyNWpxelVJdUpOalZu?=
 =?utf-8?B?S3RleThvMm9UOE9JVHNxcEticnVHYzZTc0tyclFyd0hncDJhZ1lES2Y0T1Zp?=
 =?utf-8?B?aWV1M2x3cldVZE85MDA2NHQ1TDhhanVqZkdhN2ZRdDlYRnNCYnlxMUFmeDBk?=
 =?utf-8?B?dHMwY1Q3NGtDMHZzV0VNS05PMUlSbnV1VW9ZcXFPbXN1eXhqOTJBK0p1V0Yz?=
 =?utf-8?B?MzdmMk5URUFCLzlXSlpNdndSWnhXMnBGeldrdmNwRGxCczkxbWRNemZYZmJ4?=
 =?utf-8?B?R2ZOeHJ6NStjandJeTM1ZUJkT1ltQWJ1ODdYdFA3RjNVZDlzTGxFamRsUGIw?=
 =?utf-8?B?cE44cTIySmFhUjdTWmFBMmg2enkydldHK0hoNjZZeEhsRU9ucnBCdmZwbGZm?=
 =?utf-8?B?Qnh5T2Y0QnFUTjFBTnVhMlpQVHhreGJobEpVZDdxSDhEajFCUEhyOEhFM1Jj?=
 =?utf-8?B?bWRhb05yaitPUDlJSUNLSTQ2Wm9DaTcxbVdYRUlTS2o2OUdmeDhWZVpMTmdy?=
 =?utf-8?B?UVpXWHhWeGl2MUZLLytHangvaVlSZ2tPQ2Fic00xUitRWFJkQTZXSVRjRXJ6?=
 =?utf-8?B?a0xwRUY1R3dCY3ZmWkpzN1h4SU92dDFOT0dHbGhtZk1Bb2pkNmt2SlY1Vm1W?=
 =?utf-8?B?c3lHdjNMRzdTelgrWi9HRmNORzJjWkZ3VDE0Tk9XSnhZckw0ZXVaK1FiZXhm?=
 =?utf-8?B?SjIrUVF0VHNmV294TmIrM1BOUEQ1TlRHTnZxcFVoVDF4SUFZZDNzdHA5S3JY?=
 =?utf-8?B?cVhoZkYvRUQvTExMT0MzY2MxemVvRU5Wayt4Q0xacjF4SFdid3hzc0F3THY2?=
 =?utf-8?B?MnRHcExzRVRpVVl4elhFOU1LclBwWUJQTm4vQlBvdUNDMGFsSjliazVlZzZU?=
 =?utf-8?B?NmF5SS9hd1IwV252TjhhUUxVUHVISFJDUElIOHhwZk4yb1owRFJJS295Vkx4?=
 =?utf-8?B?YTdOSDFoYVUzRVdNS0Vvcmlzak5keVo3YjA5a2dFT3FNTHI3TWpsL1VNdmd3?=
 =?utf-8?B?bVB3RXZLSzdITjd4L0hSSjA1QW1JSUEyY0tZUm8rZTJBRUJWdmxmcXg0WWgv?=
 =?utf-8?B?aFZTcHlkcUZ2Mm9UMVFTNTlzbktVU1lnVng4UjhoL0JwRTJDbkFrTUFMS0RR?=
 =?utf-8?B?YmpHV3FUc0ZjNW9tRXFJUFZoOUZVdWVUai9oMkpZWFhtdDBLZ24rV2FEejl2?=
 =?utf-8?B?YVFRaCtQbHZkTTROMnQ5c2tyMnhZbjhuekVVcFA4MW9acU5QUTNidVh4Z29Q?=
 =?utf-8?Q?gkrGPsEOglZjHqtUlpGOIcDD9uzPPOUWaZ+BE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnRGSVFsM0tOeGs5V0M1R1E2WFhnazJTNXZmWldVVWZqTlFGYkhoUjRtVFk2?=
 =?utf-8?B?cWtkYlgzeVRrc29mYWRyYkUxVmRJdGFKMkNHMU9OYzNIOGJxaG5tUjdpK3Nv?=
 =?utf-8?B?cFVWaUI5UkN5NmtFTnNZdXg5Z0t3MjFKWFFMdkE0aWFIUjNkT1VUL2ZrWWpM?=
 =?utf-8?B?OUlPdStIdEZIUXdZT0FyUUtUdjIyTHc2YzdyMGtrQzFVM01vS1o5djFZdlZ6?=
 =?utf-8?B?U2YydXEyOWwzUi8rck5KRDl6bTIzWmJmZUZUTExJRGx2ajM3UHlxTm9vekF4?=
 =?utf-8?B?UnYzcG5zVjJucytFaElLZ1FCajI5N2N0aVloV28zSjduVEpGa3pvdGJhU1cz?=
 =?utf-8?B?Uk11cGIvVjFra2JDTnNxTTlWcUZzZU40N1czVkkwSVNBVG8xc3hzZnRIYXB0?=
 =?utf-8?B?RUM5R3IxUmpHM0c4OWtwNThrdUxRRUk5NlAybGNpM2pHU2ExdXV2N1duS0Vl?=
 =?utf-8?B?aDlLYlZ5cjF3YXlUUWRIcGx0c0NiKzU1ZnNjd2VTbnBYRkRzdjdsNENObm5B?=
 =?utf-8?B?Uko3UmJVZVFhbGVuV2QzaFRoV01qYU15dW5VSlJNZElKU3R5Z0J4cFl4WEVz?=
 =?utf-8?B?enIvTTBNNE1pNS9vUUtsalBza1ZrS3dlZTQzZXVrNlNXSDNGa2IxeEZ5OU93?=
 =?utf-8?B?bldDSmJNcjBpb1c3VndWcW5XSGZyWk1QSVhOUGxTQVN0YlVueUpxWWJNcm9w?=
 =?utf-8?B?QUtpNWdUbFQ4Z0EwNFhWSkx5MVZxUXlabTlVZGpIN2VDaThxemFHaWllK0tT?=
 =?utf-8?B?TmRkNlphKzBaT2lkUVNuWDVoenFQRldNeVRFWC90TGZEQ0lZSjc5SGd5TU9a?=
 =?utf-8?B?NkJLSUVKQnRmTDFZVENBeFlWbUpJRzhmSFNYT1hrYTcrVlk2eWVQTEhOc09u?=
 =?utf-8?B?dnIwYy9uNzAvTzNFdmpsc1dLU3hrb3JxK1NUYXY0M2h4YUhHUmxVbCs4SXQ2?=
 =?utf-8?B?UEwrMjJqVHdUVmE0QzlzenIwS1Z3YWdyWVNRM0M2TWptMy9lM3pqTVpVN0w5?=
 =?utf-8?B?anIyQ2JUczdqaUx3cmMydFVucjJVcnd5VjlDUEhia2NqdU56TlpOS1BWZkIx?=
 =?utf-8?B?R1JvOVpHa0hLNWRwOUdkdEovWDdGUjVmNnlxZDQyZWNnS2dmS2hVNTlpc1Z1?=
 =?utf-8?B?Qk0zU0VzeThWc2RFeUJRNW9Zb1NhU1JUWFRRWUExa2VSeENCckVkcjFWTkZQ?=
 =?utf-8?B?TzVqL1NxQ1JNRG5uN2p3K0cwU1NoNHduTHR2MUY4aFZzOUpzdVFQRFJQRmVM?=
 =?utf-8?B?d2lLZDRXWjN6a0J2TlpFMTNxbUtIUCs2aWtkekUwVXYwMTJiYkpXY3Z2Tndu?=
 =?utf-8?B?ekxvU2k5OUVzU1ZuOGw3TU11bEdLbUk4cGFxY3pIRWhoSGo5SHI1a2tsNGQr?=
 =?utf-8?B?Rk02L1A1a3FmVzhQeUduejdrUDRzdU9VZk1aaXVwcS9jTWJSNnZyeHFsdTVE?=
 =?utf-8?B?ZzBHRGc2cjIyYlJSa3RDZnBMa2JSLzMxaERzNnlXM1U3bkp5UkliVmJTYjhG?=
 =?utf-8?B?VXdYNnpZNU1Nbml4dXRuUlgxSVRBTlNBWnBJUzBxZXB1YzZkQWtOb3B2Qkps?=
 =?utf-8?B?QTNqSDBrNzgzTUV2YmRjQW1nbE1zakFXUGhyN1l1UFpwa3ZWakNxMVlFbmlW?=
 =?utf-8?B?dzdhdFpHQ2x0S2hITFIrTStkRVZId0syaUhoS3hZYld5OGdyT1JHdGt0TXZR?=
 =?utf-8?B?VTJmbGpEUS9BR3Z0N2Vpc0V3cnc0cVJ0dGpEeUhsVW9HV1F0R0FFUG1ETnFX?=
 =?utf-8?B?MUdnUG1JbHZzLzVORHp2aDNidU9KRUUwSDVBM3BScnplVUtpWGVkcjQ4Vjdh?=
 =?utf-8?B?cXRiaVVWZW9Pdzk2bThPaTRQY2oraWgxWlVnMWlWWEM3N2VNOFZWd3F1UDFB?=
 =?utf-8?B?a1FlTFBJMm1kcTZ5L1FCY3ZnNjcxb0d2RkRoaUtWLy9wejF5b2dySkpjK0U2?=
 =?utf-8?B?S0lzQmFjdjhTNzRkRUxjRHVRNzVIbktKZ2xUaXFjMHM3VnBPVC9ST1RLNEFE?=
 =?utf-8?B?OHFCdDllUlZubmpoRWhBQmJoR09KUll5NDRmQTdUME1LNTBnd2F6RnZuWEVT?=
 =?utf-8?B?R3J3M1Y5UmpSNCtKYm5TZzBwQkN1dmFVQ0JyRVZFTyt6VmVnckF4Rk41Z1Vv?=
 =?utf-8?B?U0EwRnlBQk4vZEVxS2M2K1kvT09QNURuNW9hUVpRanZUUjZqKzlpeXo2UkZo?=
 =?utf-8?Q?rxTWuUvdFwf2L/Zcp+V0tMg=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d64d72-be37-46cf-dd0c-08dd058c4da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 15:43:51.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jf5d5PW1k604I45iszju1DUa/zPFNdMbrXrik8toXCHDrH3AegGYa+6aiK2F2ryCMzkNMn9EYRUZn7oRZYO1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5426
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <768ADFDB87824140BDD0DD7594B76767@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: gRvhV_0Scaf6Aea8htKRi67zej07pnHg
X-Proofpoint-GUID: gRvhV_0Scaf6Aea8htKRi67zej07pnHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 14/11/24 15:06, David Sterba wrote:
> >=20
> On Tue, Nov 12, 2024 at 04:00:49PM +0000, Mark Harmstone wrote:
>> Lockdep doesn't like the fact that btrfs_uring_read_extent() returns to
>> userspace still holding the inode lock, even though we release it once
>> the I/O finishes. Add calls to rwsem_release() and rwsem_acquire_read() =
to
>> work round this.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>   fs/btrfs/ioctl.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 1fdeb216bf6c..6ea01e4f940e 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -4752,6 +4752,11 @@ static void btrfs_uring_read_finished(struct io_u=
ring_cmd *cmd, unsigned int iss
>>   	size_t page_offset;
>>   	ssize_t ret;
>>  =20
>> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>> +	/* The inode lock has already been acquired in btrfs_uring_read_extent=
.  */
>> +	rwsem_acquire_read(&inode->vfs_inode.i_rwsem.dep_map, 0, 0, _THIS_IP_);
>> +#endif
>=20
> Please put that to a wrapper, we want to avoid #ifdefs in the middle of
> functions (there are exceptions), especially when the macro is for lock
> debugging.
>=20
> The wrapper name can follow naming and syntax of the other
> btrfs_lockde_* wrappers, so like btrfs_lockdep_inode_acquire(owner,
> lock). There is only one rwsem in inode, but for clarity and consistency
> I think it makes sense.
>=20
> btrfs_lockdep_inode_acquire(inode, i_rwsem);

Thanks David. The CONFIG_DEBUG_LOCK_ALLOC #ifdefs turned out not to be=20
necessary, lockdep handles this, but I'll create the wrappers to match=20
everything else.

Mark

