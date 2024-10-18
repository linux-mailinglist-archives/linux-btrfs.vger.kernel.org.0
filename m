Return-Path: <linux-btrfs+bounces-8999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9976E9A44D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA41B1C23804
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024720402C;
	Fri, 18 Oct 2024 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="efR+H33K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8B2022D6;
	Fri, 18 Oct 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273021; cv=fail; b=ir7rqctQ0li8O5qhn9Sra0Df07BTCdVbPY0aPvEKVh5f9TVAe1E85mScGwd7z9+nrocxBFEiRKSJAU293ytCW3+LkP+AMJjVWER8Yuv4edPETTrNLGFHBkmLdaR7ZrLyi+flj0pnLnTAuf98m5xGi2F2u+Qz4mPaZ8VquXfuOOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273021; c=relaxed/simple;
	bh=u02nSX2UJL+tkWyygr/gbeKkg0q3aDpi7TmVxJOeJsM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=bmYj8b4+SsXqIWFsw/j/toi7h2J8LRJ3SMXWUegVm/8zBE+qsWj5EJxAVxxFxQESwJYlqXR/dDAF4uucr8AH4PFwFbDQoi07uphzpU59p3D3T7UFhAbP0ONtZvfoegLbjSrjZwNaQQvf+Zw6Jb231cfyME5LrMs6erPmAgaI61k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=efR+H33K; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IHWvSQ014655;
	Fri, 18 Oct 2024 10:36:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=cazD25JbJpOu0BcIw8uodfJFWPS+9C9l596psi002ow=; b=
	efR+H33KJGpLIEIzovyOOaABRcjP2D6Vx50WYHiLReLs0w+dmYYmIZJIWNw3RaC/
	qYRalYYOPAtLp/pu7W/oCBnCGCsYRUZMQS+vZVxhpT4VYw64W45Lx/GvbxKSGSc9
	JeNWP0fq/g2XHFUaCJbXLw+uxzMqCxsx292bvBLBq36xCo2eoEhimCaUBXsFR3/z
	DguyV0u0KHuxjC+y6K+oEXlMfHkcI2muPnAaUUwLj0aU1HsFHZPHqUlYvQR+7kFu
	XSyp5lkh/jj2fyrP57rQvjlmq0a6N5FKP2Tlb6ZDWzI2kNvUvYropgAUrjywa8q5
	AxR+FIJcQoiVyMdc4YrcRQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42awa44rrm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 10:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idd2I4OvO9govJwueuh3YJqAHMx8rx/QhxHveQvg1ItZj+y1z9GCUGAcjZ/TfjdsTIyUtvSQsyv98fB0orMaGZor7D99llLZ/v60yCQg41c/wfKfYHqJHHWo7mDXIW4cbhjCbKJDjeXQN9MNeASC64dzIXC1VOyp4QlSmHX7teeNMwheYZh/wvljIqciBZTCSD8VEuJ5EMJyTdg/MIPq3fdpPq5JU3VJOmprSESa98ACB7bYXLGFJf+Lyzf2mOvAVNOKuQp19zhMfyLwZgnVPiJiz58GC+5PqpyCPNIQO8tIF5hcvQ3XSIA5aO37itYVnKKpVrBiQxtGUTbb3kVvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqhmvWKMlrac/WjIW+ly/GIUXTG7Mk88GGQ/rBZQCNM=;
 b=Y82c30yYeisMKa3oKCr3rRfySeOJO0S2inzpzQMPkDzbUEVUtjE9omSmw/TCSM+tSxYHRf68kOnB4DG6NsL/xwlmRKQFB77hTB6UuGo2QeF7zuV3Do3XsNxtuAXflIsIwjCa8Egw3ZuaGD5RgyPGfCZiQFOuaNzkq05LIZlvDqCH6FlHGZqT3c81tHqyqU/tAmvTX3xIlkdLS71/sRAAHkNLGF7b0Wjkr5QnErxiu9z+NW1vxqf5TE+nvSZ2AP5DtCYLuY7zsKYTEpxnbZGd/RuSOiP+I46R10urr2vMdVzQO87MERp+krj77ZywVud1uKEn3pkPbbjq3D98hd6jjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5659.namprd15.prod.outlook.com (2603:10b6:510:282::21)
 by MW4PR15MB4731.namprd15.prod.outlook.com (2603:10b6:303:10c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 17:36:26 +0000
Received: from PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d]) by PH0PR15MB5659.namprd15.prod.outlook.com
 ([fe80::dffe:b107:49d:a49d%3]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 17:36:26 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Filipe Manana <fdmanana@kernel.org>,
        Mark Harmstone
	<maharmstone@meta.com>,
        "zlang@kernel.org" <zlang@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Thread-Topic: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Thread-Index: AQHbHxiG5VfUS1reGUKSxW3KOmM4ibKJOaAAgAOQsYA=
Date: Fri, 18 Oct 2024 17:36:26 +0000
Message-ID: <d94875db-0bed-4077-a2e7-915e7358c1db@meta.com>
References: <20241015153957.2099812-1-maharmstone@fb.com>
 <CAL3q7H4wLLTLi_sfKEQB8qsQ6G7VxWBfK_4FwSi4qL5Z3bkycQ@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4wLLTLi_sfKEQB8qsQ6G7VxWBfK_4FwSi4qL5Z3bkycQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5659:EE_|MW4PR15MB4731:EE_
x-ms-office365-filtering-correlation-id: d35bced3-ea81-49c6-ffc0-08dcef9b645c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?clJxb2R5ZGs5aUVaam90MDRLbjlUR2NyaDdDdWlEZGdXQ2d2UU52VFNyZWRl?=
 =?utf-8?B?bEZnOWJ4bXhtcWlLUjI5bUdGYUV6MTQrU1B1ZllCOTVYUlFVK2NyK3ZPdi9G?=
 =?utf-8?B?aXJobnBVZVZZbjFrSm93c0lxckVESFBxbFR1WHZtcjFYN1dHYnB5QlBIUC94?=
 =?utf-8?B?RVgrK1B0YnJaSTNpWkdmOCtkZ0V2L3l6SDR6ZEJnTVB5YUxOTitxWitwbERS?=
 =?utf-8?B?MFV1UC9IVHhucnRES1JUWkp0amVCa0JsWm15VUQ4NHN2VkNMZmFvT1JKMXN6?=
 =?utf-8?B?VWZvRk92d29zemVWVHlHeW1yM1Y4NDRqeXFldU1rMkpnYmtDV1dzTGdLL25E?=
 =?utf-8?B?QUhKVURwTFI1VmZBVmdzMmRlRnlGa2pWU2hzanhJbThGY2lidzRTaVVSU3VQ?=
 =?utf-8?B?RjRYSFl4MDliUENtM29Hck5CNXVJeExsd25WdnhNN0FCYXBPYWx6Q0JHK3N2?=
 =?utf-8?B?SElFTkJMZEhDTFJiVmJpbC8rZTliUWdlaHZHWG5NMHZzR2ZMWDFVQkNCS3kx?=
 =?utf-8?B?ZWRoWnd1TmJNZy9QOHlpWTJ3TTVZY2lZMWpSTlhPUUxQdU8zZEJOZ0VNTDhQ?=
 =?utf-8?B?QTRMV2d3UFd2UmxEVVhuS0RpMHZXR2FhUUx0cnZyYTBQaS9wMHI3OWNLcmVK?=
 =?utf-8?B?bzBibnFZV2FIQ1oya3IvMHROV2szSmlGbHQvRnBuSHg2OGJUM05VM2tMcnBj?=
 =?utf-8?B?Wm41YjY4VGlrTktEbDNFeHZJVUJUL0JZTWNIQTlwM0M2QXo0a2dOT0NrcmlS?=
 =?utf-8?B?TVVyeHZnS0Z4dThqOUlvK3lMYXd2VEFmYU1hMHBNMXNqY2l2b2FrQkRuRE9X?=
 =?utf-8?B?VnVqa3JDSHcxK3JqMWY5QXJ5K2NueUw3NlcrWmdDbGNubE5iTnR0TU81RlJ3?=
 =?utf-8?B?YUR0QUhUaFJJeTdXaTRWTUNrQTk0ZzVVS1dBTXJXN3JsRzlCRm5IMFhIUU9x?=
 =?utf-8?B?Q3MyQmtIemtsU1hTOHNtUDRhVzRHWGQ3TFVycFlRUFoyYzNlRFFvcVFEMk1Y?=
 =?utf-8?B?RFNhSTdRNjllL0NOVEdkbTJCTG4rck10SGJ5Z01WYThvcVZEWFp1Nng1TEM2?=
 =?utf-8?B?WWxLRXp1a01pN2Fxb1RpdTRFMW8zZ2ZIT3Y1cVlVSHlybXdTb1puNzdDMEFu?=
 =?utf-8?B?d3c0bTEyVkJiYVdLN25RaUQ2YUU1OWI1L0xkNjNkVUxXTnJYS2xRWU9TYU9u?=
 =?utf-8?B?QXA1bHVJWmlsTWlyTzRVcE9hMVZ3ZlB0cXNLdEI5eTlGaUY5T2h0a1lla1hC?=
 =?utf-8?B?Slh4NG9taHczdlZKcjRLQ1JHU1R3Y3FaZFRVUk5reTVLZzdqWkxubXp4bGRP?=
 =?utf-8?B?dlFhNlYxZkJXekRZWmxFM2JSVUVMV3MxUEU1UEFPQldtWDQxL2NzVy9GZUs4?=
 =?utf-8?B?ZjVTY2xxcCt3Zk1FeDh0Sm9rTFlHSHVvS1dJbk02SGNDVGZaS1RlNXZ2RmEr?=
 =?utf-8?B?b3hyZmxReTkxZFF3T3A1T1NUanhld1RMTVpySG05ODQ2NkNkamhOL0w4dmFG?=
 =?utf-8?B?by8wb1lIRzRFUmxhYWxWTTI4TmZ6NmU0OTRDN2dXMUd2UDNycDl2MWFSNS9h?=
 =?utf-8?B?YWhJcWhVT240NUY0ZVEzQjNUV2pITTFSZG15UFVkKzdkRmlPRGMyYUJGMEoz?=
 =?utf-8?B?ZEFaUU9FOFB3QXQrRFE3aWhGcXA5ckFDU2ZUb0d4NlRHL0VLa2xBTzhtd2Rs?=
 =?utf-8?B?Q2V2MC96MmtoWVNDdzV3MkdnQW56dWphdDVvUmZqbGx1WkZnOVcwU3dHYXBU?=
 =?utf-8?B?aWU4U1BxWTR1V1Z1bVRINVpqZnI0UlIwV29hVnJiU2FHdmNNNWNhanc5KzFj?=
 =?utf-8?Q?HnHeHi+6hPWzxfy9swC1BJtX2NOMIyEetMD/0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5659.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVdJTGd4aVM4VkFld293WFlKcmJQSm5DNU80cWsvTmJEWVBLZjlzMHBQVXNM?=
 =?utf-8?B?QXBrUHJIVWwveWRST2RqVk5uK1RMZ2VqenFhcDIvaWo4NDl0Q0pnQlYxbVVs?=
 =?utf-8?B?cytMRGZzSUtWYnZKSjFyUVJ2V3dsRzNIUDRJc0RrbTFhdTBqV3FkVENQUUg3?=
 =?utf-8?B?QWZmeEI3RXFZcWdjUm9vUUl5THhaMkprRUY1ei93SE80QXVGOUt5WUJJQWFN?=
 =?utf-8?B?MFduQms3U21hc2ZRb1d0c3hKd25XdGZscGtkdlJFeUdTVng3aGtpVzZEbmd6?=
 =?utf-8?B?WjdPRXBzMFBBT3k2eHNTOEhaRnpjMkFYclVvQytFUDdjMml1WjVESUluMjFJ?=
 =?utf-8?B?bURZNG0yZXVFNGY5MFlkVHJqalNMUkZXYmJyeDMvTCtkNWM2ckZ4dWJUdUdS?=
 =?utf-8?B?d2hYYlkwcUIzMG80M0hxclNKSGVsWDhja2lDZWFRQkJaNDlmVVRKWlp1b09W?=
 =?utf-8?B?N0lpRWFsZ0sxdndVbHlxcjBVWlI4RHRhRlpYVG1la3JNRjA2S2xZZ1k4eTVz?=
 =?utf-8?B?LzJYdnlQUlhGT1hMby9rVWtDWTYyL2VaQk9NdDJHMlNJcVRxMmk3RmFwSVdx?=
 =?utf-8?B?d1lzTHFvdFdlRldjUC9oLzk0UU0rakRFYlNTUWlBWjRHcGJyZ09NSUxiZUl3?=
 =?utf-8?B?QnFHdVRYcmVHS3NzaVNsbWRjTGx1VDdrS09iQUExQUNrR3Bxc1J4YlNlbm5J?=
 =?utf-8?B?UFM1Tlg5OXlUU3pzNW1iMTFRbitJVEl1MjUvaHhzb3lwZW95djdTZmQxUWNM?=
 =?utf-8?B?QStVQmdTTkxBOXY0a0ZJamlOamZLcE5yT1FmTzhpMEFCdGFJV24zQjNRcTlE?=
 =?utf-8?B?Q0xLSEZhUzJUOHdtNndJb1p2bDFPNTJOWElDbmlWaC9IUWhOQ3ArTGNHVm43?=
 =?utf-8?B?djZnWks1TzIyVVQwUks2K3J1MFpvWWtjMjUycFVGNlNZVE01b01IZ0ZadzVk?=
 =?utf-8?B?RHhPT0hRdWtsTWNVWElDMllPbGJHcklRVUdveFdJdWZhczFNbkhXRnBsL1BZ?=
 =?utf-8?B?bkNXK0xPd2ltM0ZXK3R1YzBRV3JoazNFUStEcWtMa1lUazNBSjVuYXo3L0ZC?=
 =?utf-8?B?bExWVEtTTTRZa2xpemMwR3ZNNDFqR1Fkeml4Zm5XeTNFZ2dDRTQ4SjIvMjU4?=
 =?utf-8?B?bUhHVm9WdFkwUC80QTV0Y21BTGNIK1ZNd0UyNXFJbHpDWlQ2ZlJuMlpsQjhx?=
 =?utf-8?B?Uy9zYUlVNE1zbXZxWVFuVE40Qzc4bEt2eDV1UnlVL1dYSSsxbjcwYWYxN2xk?=
 =?utf-8?B?K21KYlpsQXMyN2F3YnZ5d0hsTDNNNWxIajRpUXl6OWpFSkNIZzRiSDIwclky?=
 =?utf-8?B?VVZpM3YyN2o2VVZvUUdqSEN4TU05KzZ4YS9SZ3R4QVJjZjh0SzlCZVorMng0?=
 =?utf-8?B?OTR0WHQ3UVM1b3oyZ1MvdWR5bGRlaVFWdUJQUGpPa1lCVjY1YzZET3lIK3lv?=
 =?utf-8?B?NnROY25DaTdkOUQxbUZidHZWSEVhYzlvVlFWNGlRMWxnUExDOWd1QmVuejkz?=
 =?utf-8?B?KzJueU9yZlphd1Z3WTBXdGtlcURqN2ZmRXd6NFhlNHpmUUpMeEswdjdnd3Nv?=
 =?utf-8?B?RFUrZGhDVHVHY1FwbmhkdDduWTJlU0xQQ0dUVUQvVzFzTzdObloxRDFsMDFQ?=
 =?utf-8?B?azF3U2Q0c0J0Sm1xSEpzTXFZQkcrNWF2VHUxc2ZwNUY2ZVNJOGZrVVIyaFc4?=
 =?utf-8?B?dGo4MHdFbm1YN0hoemRNeS9yQmJCcU8zeExVb3pYYVJncmhNSVJOZGZRVW9l?=
 =?utf-8?B?akZBZ3hGdjVjdUpmUk51Z1VJK3NUTkgxT1lzRDFCaGdLZGltdUVYQS9hZzE1?=
 =?utf-8?B?dCtZdkpuMFJxMmt0dXVETXI0aFQxYWdTWFc0SXhZWVZRMjlLQlFVVUtqWklC?=
 =?utf-8?B?QlZyOU52YVdBUzZXZU1WcVlvekNjRjB5Y0ZFSnNtbFpqTnhzak1SdjhpVTlD?=
 =?utf-8?B?NVdtdFI0WXc0QzFmZGwyQUFRRXdkcmhkcVc0Z2xWZVJKSUdKZ01uNnZDYXhy?=
 =?utf-8?B?S3hjcjNRVWNCZGxnaUZOMVZCd1RBZ1R0VDhQMzVscjg1bGdsZ3ZocHkrYk5X?=
 =?utf-8?B?TDc1c0c2WXE5dUo2blJLd2NPbEh5ZGtTNkJBQW8xck9xMWttNzU2clNKRWJF?=
 =?utf-8?Q?Gw/c=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5659.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bced3-ea81-49c6-ffc0-08dcef9b645c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 17:36:26.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCIIqAAMDzmC/7xo4nhaoRlTR7E6jEOZD5cGMAR9y1VRo0jqWgb7fYTzFECS2GbTA993fhhqdkCYUjwDTsQyzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4731
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <99B57B2F3C490E4E8077F1AC104AE60E@namprd15.prod.outlook.com>
X-Proofpoint-ORIG-GUID: SxF60TETsSsV-SvqJnQpAklY_PTjF2l3
X-Proofpoint-GUID: SxF60TETsSsV-SvqJnQpAklY_PTjF2l3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

On 16/10/24 12:09, Filipe Manana wrote:
> >=20
> On Tue, Oct 15, 2024 at 4:42=E2=80=AFPM Mark Harmstone <maharmstone@fb.co=
m> wrote:
>>
>> Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
>> race could mean that csums weren't getting written to the log tree,
>> leading to corruption when it was replayed.
>>
>> The patches to detect log this tree corruption are in btrfs-progs 6.11.
>=20
> This shouldn't be needed right?
> Because after log replay the csums are missing and 'btrfs check'
> detects (IIRC) missing csums for extents referred by file extent items
> in a subvolume tree - if it doesn't then it should be improved.

Yes, but we're not mounting it in the tests between the log_writes=20
calls, so the log isn't getting replayed. The patches to btrfs check=20
make it so that it identifies filesystems that would get corrupted as=20
soon as they're next mounted.

>=20
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>> This is a genericized version of the test I originally proposed as
>> btrfs/333.
>>
>>   tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/757.out |  2 ++
>>   2 files changed, 73 insertions(+)
>>   create mode 100755 tests/generic/757
>>   create mode 100644 tests/generic/757.out
>>
>> diff --git a/tests/generic/757 b/tests/generic/757
>> new file mode 100755
>> index 00000000..6ad3d01e
>> --- /dev/null
>> +++ b/tests/generic/757
>> @@ -0,0 +1,71 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# FS QA Test 757
>> +#
>> +# Test async dio with fsync to test a btrfs bug where a race meant that=
 csums
>> +# weren't getting written to the log tree, causing corruptions on remou=
nt.
>> +# This can be seen on subpage FSes on Linux 6.4.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick metadata log recoveryloop
>> +
>> +_fixed_by_kernel_commit e917ff56c8e7 \
>> +       "btrfs: determine synchronous writers from bio or writeback cont=
rol"
>=20
> For generic tests what we do is:
>=20
> [ $FSTYP =3D=3D "btrfs" ] && _fixed_by_kernel_commit .....
>=20
> As long as the failure has not been observed and fixed on other filesyste=
ms.
> In case one day a regression happens in another fs, we just add a
> corresponding line using the same logic.
>=20
> Otherwise if the test one days fails on another fs and fstests
> suggests that that commit is missing, it would be odd.
>=20
> Everything else looks good, so with that fixed (maybe Zorro can change
> that when picking the patch):
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>=20
> Thanks.
>=20

Thanks Filipe. Zorro, let me know if you're happy making this change, or=20
otherwise I'll resubmit.

Mark


