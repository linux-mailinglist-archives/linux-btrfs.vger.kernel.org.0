Return-Path: <linux-btrfs+bounces-3057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63043874A47
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 10:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17022281638
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F98C82D93;
	Thu,  7 Mar 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y6GEiyi+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AjiZ9uNr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008581C2A3
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802051; cv=fail; b=ooOeuU2QyQSxopspkU+k0XVLw/slO1p5UUBE1UKlqcl7OlP6VgQmuZ+IrMmmncZf7Xi4cw9UfUr0HcbEkOajrMrvVnejO8VbERWN3beVlZV81pLAJV5mcQHgPiyT5yIEst8JgeldddQV+IAxkGlD45WnCkJBBLeJ8q0EjaHT2p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802051; c=relaxed/simple;
	bh=RfW2EElqc8q+UuXiduUS0IEmCnNr5h98tqEtugY9wco=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/b4RgA0CEBGDWso/0FblA6448Qq0Mkm/enHGAz/Dm3cNyXUso4iJSmUpp+LrGySvdqQ85ASOAOjnz9yps7jS1jIYuqEhvU863vRF/fji9rQ1aZnqYYODq+X/mE/vp6atZquBciTQaWuvqggPVvhoF/8k3T8dMKn2QF6LPyv33Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y6GEiyi+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AjiZ9uNr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4278aQCP003004;
	Thu, 7 Mar 2024 09:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=gOHJZiq4wMEhpYxBSY0HuAAOdEda66gHMa4oh2gnyNw=;
 b=Y6GEiyi+fr5hJL67MYukzTSk/h1yguRfN7h5zIB7lZ+R+SXfziND4IfXnDqd/+3pLEK9
 Gjh/xAEYjWP9gnnBiPpMylMYPrpw8AitiMWUhJGH0LuAm9ni12y7fIT5LrnhiGfgyCEU
 yGr54emdDasaEr1ilMde/SGtrDvXqQF3ApEhG/NbPqXnFGEGGeMFVxOL76WcMZ700ybn
 6Y15Fl/ucSFBCZ1bT0npBRf4imRmsNDP8zkgFiLxAaj5TaK2qMyuhcChLOpe0ox2L/Y7
 uf9SGHkL2pBLm0PDrkikIVPkzQVNkk9AgrauMOdea+ntugHlXeSHOKOuzmZBGGtE5z2F 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dkjuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 09:00:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4278Df82031891;
	Thu, 7 Mar 2024 09:00:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjawr48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Mar 2024 09:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmwBs7j+OPFkhOYVz3ODSEKIpThvko2FLurkCk1Hsuzmpeb3VM+AXi54epqckpttvrQaHdwmAvF7ElHlgGVe8Q3JjlwGTxIG2u6BU4ku38Wve96+WASqztKLtujuqbiGxjDWrAFMhIKAYvqb21PLZBQhK9yqP2IyKUbrCqXCq9NPDIcb6qzzajrezVjRIVyJ7nuVGkxthV66TXnfqMzZtnI52lnwqqG4sEO3sZnYuwdbGxodIeS1qRXA+nlpakKcK62/TxTHbQVQs/RE5PCe9rPkkuScrWQrTd+D0k+h+yLCcZa+KxKi/L6/Sao7l8BcfHA6guKVEkq5s87fI5Er1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOHJZiq4wMEhpYxBSY0HuAAOdEda66gHMa4oh2gnyNw=;
 b=gpMfl8KfamVNIQk6hDxtfTkF1sAHNSpI65mQWNIa957AwljaomXmBBkxZYA2DEXHRlNmxLs8lSa/6w6crw9Ha7UFPJaMrciEyxAtLg+LQndmm/dIx52A3U6tUXqKmKc0xP8DIBFQRAlcyfZj/nJ59fxa4hn0v3lVC47jEI1gLVw9UuRG+PrHLt4ZX7L+SRSoi4lN7v+NHHCqLtO9aoVUGbuySJwNAE454T5t52dhXB0SlAakkLuBngLPOHOQZuqbK1uZpS6p2H8TyTyVEdDJBa8URYswLIuugkn+pHl/G23yBzxQ7Jz0XtPQYE/umQf5wf6NR/UU/dqlxG1T99k5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOHJZiq4wMEhpYxBSY0HuAAOdEda66gHMa4oh2gnyNw=;
 b=AjiZ9uNr2Tka9Tz7Hb9dUV9asH6uEZXmnVZXe6mmK7s2OFOCILaBjFuhRrfwxe8BAZ3JJI8bgck88QhNKkJR1ivh04gM9nbZ35Eq5V6zTS71nHn2jP3H69ypUPSvyTIp2gXOS6Ac9Co7Kk6Fx2aBBzDbVsB/xnn9/UrG/z62l9g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB6433.namprd10.prod.outlook.com (2603:10b6:510:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 09:00:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 09:00:40 +0000
Message-ID: <fddbfc5c-e1e0-438d-a696-a2ec75e8de83@oracle.com>
Date: Thu, 7 Mar 2024 14:30:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RFC] btrfs: do not skip re-registration for the mounted
 device
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
To: Alex Romosan <aromosan@gmail.com>
Cc: linux-btrfs@vger.kernel.org, CHECK_1234543212345@protonmail.com,
        David Sterba <dsterba@suse.com>
References: <e2add8d54fbbd813305ba014c11d21d297ad87d0.1709782041.git.anand.jain@oracle.com>
 <CAKLYge+wer9ij5vfoJ5ct8Zy8OqHuh7vKDmn4S0vCVF05mzOxQ@mail.gmail.com>
 <4118de16-dfb8-4ed4-852d-abbd4c7581ab@oracle.com>
In-Reply-To: <4118de16-dfb8-4ed4-852d-abbd4c7581ab@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 192a72a8-abdf-4239-531f-08dc3e85101a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8mCxDev5RN4B1mIw5Mp+1E3aqI1UqmaOBkFpOB+P0TOdlIvlEaITAV4t2/cVbuqO+U0I01YO1QAOvt8wHZfzyi2HLE90nLnzla7VCVhhnd1iNAs0kmeuJi25LTEQW4q/PGMMUihHekhzSqKGsq0zSJUsiGlN1O46N0F/tLWclZNfTenbzJuasErNUAweXy9iieo+1xJrzUtV0J2xC+xA7/mpNo7//ahrInFYFXL1EX/55O0AMVbqH0LzW7VTfCRgDjEPjwQl0EI0Mo0qknpPjYl+V4Fj5VxKabSTG+DMFWs9TVrQcOnUQsQ5TBE3tFScGHudnoYApOjsbLffkli5FY0Vg4euG6Xt5hNnLnb/BsoSk7TTyJYZhd76W/Bq442Fa1UdTCyB/eA8M5CBiFQWmdNa9Xvfp4G03wr0y9UqwOtLUbxuxCcFE7K/uXaLpaixhadsI5uhRVDowQIPUdarMRGg6IaRg4W99TG9kMEwc0nio3SbGyFf8y1QoRavpl0LNn6/lPP63BN9iBpDFdjL6OdpPytXn9Bab7HYDXFk8LRAwr0EqjiUqCUUlRxG74Z0nfg31EML6djTqGjDd/5cYFb+y1M9KVniUzNBKeo4yAN0AvkuVnXrSvJMJiSBN0Xu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWVzOGFJRUx5NFljQVpNLytMVFZWd0YxbHhYcWtDcEh2U2R6eUFaNjNrSVZ6?=
 =?utf-8?B?ZzEyUURBMVVKcG5jZkwyRDV5djA1STFBcDVvMEVtTlVOeERWdDhBdnhjNjNh?=
 =?utf-8?B?QU5kWnF5STJXU3kzWmU5YzhaeWdoRG8yOCsvdGJMWjZBMGVxaVpjV1M0bGxJ?=
 =?utf-8?B?cjRTeUVjVmhBV25aTUlYYXVkZkwveWNqSXB3NS84aFdaTGdyWmpoQm5HM1Q3?=
 =?utf-8?B?ZjU5cUhiSUorMWFOV290MDc0d2dFamxuSEttOGdzN29iV3pPYmc5ak1CZkxB?=
 =?utf-8?B?cXdlMmtyMnVyWTJDSkJiNHBRbEkwZHgvZTM2Skd0L0tDUnA1ODNUbzJGN2JD?=
 =?utf-8?B?WXRKNHBQQm1aeGU2bmp0VFMyVkZ5VktKZ3Btcm1QaFIyT1JpTUc0bDZjL0hR?=
 =?utf-8?B?Z1VodDBzTEE1SDFmT3NMN0FxWi9KZ3FuMkhSU3MzSks4UU1MV1hNZkoyZjA2?=
 =?utf-8?B?YTkvYVZqTmYxOFNJL3ZJTnYxK1FsQXZLNnAwRUJ4SVhQc2JQc2Y2Q1VZSTlU?=
 =?utf-8?B?T09yZEtYTDRCZ3dUSUdVckdYR245SXVONXNiRGVIQzJJSThKTlFUNGhtZnNk?=
 =?utf-8?B?VHdOVU5NK3IxTXliV3pJSFAxekV6ZmJCQ0NqQzRublUyWElXTzlDOCs2ekQx?=
 =?utf-8?B?ZThQS3hlNE9GWmdXaDFVWG9XTjRBTkwwcWh4N3hMejdlOXI0UlV2K3l2WnJq?=
 =?utf-8?B?a2JkNVhNcVZGNmVLdlZrU01aUDYyNU5yTWZicEVDVDlUNFZrREVBb3JaeitM?=
 =?utf-8?B?TlUxNTVpT3J6Mkk1Q1ZFbmEzWTR5a0hhYkY1UFg0SXdlQzhnWWxmS2FWU3Zm?=
 =?utf-8?B?ZlN1cWEzSDBhZ29uSmU4SmdqKzJzUjhZT2VpbDM4enFVb0dxK3BWWmVPVTlL?=
 =?utf-8?B?UDJCVEdBSDJudFE1TnVCZmoyNUEwK25senRKa1M5Q3drNFR6QnBpNktXTGJt?=
 =?utf-8?B?VUlxKzFUWE9BNTIzSTRtK05kS25TWG0xMERSd3JkNXpPcXFLc0ZIRkc0emJ4?=
 =?utf-8?B?eWc3RUx5TW1DZkFEQ04wRVovZU4wenNjQUJocmVSeERyVHhGcW0zZ2V3clIw?=
 =?utf-8?B?c3dsRG1UQ3BSaUxVcUlTNlNJNmY0S2ozNElxV2taeGtIazE4VnJGYmoxRlFF?=
 =?utf-8?B?QjJkUThJVVg3NytVTi9JQkNoNG1FYkVPckErUmVweFVVdm4reEVJT0V2V1g3?=
 =?utf-8?B?aWtlK0h3M1BpWWZyTXZheloyOWJnM09RcUh4cmtSMjJ4dTlmNXM4R1U3QU1I?=
 =?utf-8?B?SkRMSlB1eGdOZEdxNlQrNlNSNWkzb3p2Q3l5ZFo2d25VZ293Z2VSc0tWN25r?=
 =?utf-8?B?U1NiekdzTmsvQnpLY045RmFLOG9EK3QvdGFJTEc3MlMvSHpaclExVm41RFI4?=
 =?utf-8?B?eW9QNUs3YlE3MGtqTXovMmZGSktnNXV5alYvZVMrdDVhU1pyazM5VzZ3YVhq?=
 =?utf-8?B?RHJyYUVmYmhabFU0aWNCaG5mcldOR095MVJaemlSRlFsMDIwaGpFVkdNUHBY?=
 =?utf-8?B?VWx1N2FYSlBmeFlrM2wyaytiZk1DWE5KRkRuTHFBQ09xbSsybVk1QnhEUFFP?=
 =?utf-8?B?L2d1dzJ4Nm1XemZ0bzBGYnJCTUlSVG5jNmcvOEV0aXoyN0V4Q3RSY3JOUEly?=
 =?utf-8?B?YW1SbWlwYThrY2I0NVZtTUsxMkExMU1XVisrK295c2VZOXVzSDI1VS96enZn?=
 =?utf-8?B?RVNHckZhdGptZDJGUkNteC9RMndPc1hKeTJOV09Pa0c5L2kvYTlyRDhpWHVr?=
 =?utf-8?B?cmFTNGFNUXcweloxR1ZoSUFRREJYY0FZSlFRdHBRWUhSMk9XTDl4TU5FdGpN?=
 =?utf-8?B?Y3dKM1U2Rk4zQ0hFd3RUVitudmlTUDA1c1VxTXV2cytuZ1M0L25pUnlqQ1RT?=
 =?utf-8?B?dlJ6Wm56OW1nQVBCS0JyL3E0NzQ1aUQ2VlA3b3RpVkpIejVTWGgxVnQzMkVi?=
 =?utf-8?B?WGlSQjBKMTcwZWlSTnNXamNqM3diN2RjQUZGcWN6L2hYUHJjcnAyRWRJbW02?=
 =?utf-8?B?RzRzM3lIYTFXMG9LZTRwRGQwb3EyZ3cyUFFHN3h3eVQ4OUQ4emRzN3ZmZEpp?=
 =?utf-8?B?VzB6WjM4NVRiRGl6ZmlPUjF1RllzcWdDWUNvZCtjNGh2VElXUzJNV1BoeENo?=
 =?utf-8?B?ZmY2elo4d3hvc3l1bEpwa1RpYkluZk1KRFNJeFh5M3IveERUWmkrb0d2VC9k?=
 =?utf-8?Q?F7JS1DbN/aihO3b7y2ZDXEmB8ANGZSl3cRtECvznCl/R?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yvQ5YjEmtFV2ZhKxJzTnfHU2FXtG2BnZRr3aU6snkPAzapjpck1VEQhHho/0vLe205g5aeblEyOROUtjRxKTUzLXQ1z6OyYMH/wRFc4CShqa6rraFDUS6+9svK1b0zNqWzEzd/9jq3IIYMuc+EJHAwVM1NJ3DkAqsfAhqX5bBknTgWZmzRgyyrzV6JHe4mm1jRQcXXr4JiND72sa4ayC5RrEbBx7jMUjHMegyEVfiv8w3E1BE9pXV+9OoiqwxJtEBUxbOXUgx1inG8yoSGtyoccUKRPMda6M8c6yQtM/lAHHofk76xvM/AJBfWlw851fIzMmtFXSmF9PDgHj31LmMXYxMshcX5aY1R2enKBaRK5Sx3JcLmcZJKAEbD9uoS0bFfHIYJBbU3+JAWhMJhy5kyY5jBCYTWME3LDmOrEZVROCUYLzgp/4LxTgj6b9cLhLL4oriHqYOQ5OGSu/vhHYSk5tHCxNqRwi7TQzvVlyPTPMDp5yYHkHKEPZ70c60dwymqr+xEbpcoBb+bmFueZXjEgnu+fpsrIOKdt7dQ7J4BaD9OqxQCJR/2AK5XCe12pfFr+dkh336wy5UTKzAn7wbFEUX4Vu01SJg0w69Ipk4hs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192a72a8-abdf-4239-531f-08dc3e85101a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:00:40.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzqBBW/9/xOzLzf43Ns8DQNhf81bBWbdhxG+PLQKTtWQC4nHiAGU8Xzz3EaHQZnX3iC7sjt0YcE/77C0W9lA6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403070064
X-Proofpoint-GUID: -T9j1E7byXr68AVEprZR7ENL6XC33-R2
X-Proofpoint-ORIG-GUID: -T9j1E7byXr68AVEprZR7ENL6XC33-R2


Sending one for the mainline version. Thx.


On 3/7/24 14:17, Anand Jain wrote:
> 
> Ah, it is based on the https://github.com/btrfs/linux.git for-next 
> branch. I tried applying it again, and it works well.
> 
> 
> On 3/7/24 14:06, Alex Romosan wrote:
>> I tried to apply the patch against the latest linux git HEAD but it
>> failed. Care to send an updated version? If not, I'll try to fix it
>> myself. Thanks.
>>
>> On Thu, Mar 7, 2024 at 5:14 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>
>>> There are reports that since version 6.7 update-grub fails to find the
>>> device of the root on systems without initrd and on a single device.
>>>
>>> This looks like the device name changed in the output of
>>> /proc/self/mountinfo:
>>>
>>> 6.5-rc5 working
>>>
>>>    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
>>>
>>> 6.7 not working:
>>>
>>>    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
>>>
>>> and "update-grub" shows this error:
>>>
>>>    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev 
>>> mounted?)
>>>
>>> This looks like it's related to the device name, but grub-probe
>>> recognizes the "/dev/root" path and tries to find the underlying device.
>>> However there's a special case for some filesystems, for btrfs in
>>> particular.
>>>
>>> The generic root device detection heuristic is not done and it all
>>> relies on reading the device infos by a btrfs specific ioctl. This ioctl
>>> returns the device name as it was saved at the time of device scan (in
>>> this case it's /dev/root).
>>>
>>> The change in 6.7 for temp_fsid to allow several single device
>>> filesystem to exist with the same fsid (and transparently generate a new
>>> UUID at mount time) was to skip caching/registering such devices.
>>>
>>> This also skipped mounted device. One step of scanning is to check if
>>> the device name hasn't changed, and if yes then update the cached value.
>>>
>>> This broke the grub-probe as it always read the device /dev/root and
>>> couldn't find it in the system. A temporary workaround is to create a
>>> symlink but this does not survive reboot.
>>>
>>> The right fix is to allow updating the device path of a mounted
>>> filesystem even if this is a single device one.
>>>
>>> In the fix, check if the device's major:minor number matches with the
>>> cached device. If they do, then we can allow the scan to happen so that
>>> device_list_add() can take care of updating the device path. The file
>>> descriptor remains unchanged.
>>>
>>> This does not affect the temp_fsid feature, the UUID of the mounted
>>> filesystem remains the same and the matching is based on device 
>>> major:minor
>>> which is unique per mounted filesystem.
>>>
>>> This covers the path when the device (that exists for all mounted
>>> devices) name changes, updating /dev/root to /dev/sdx. Any other single
>>> device with filesystem and is not mounted is still skipped.
>>>
>>> Note that if a system is booted and initial mount is done on the
>>> /dev/root device, this will be the cached name of the device. Only after
>>> the command "btrfs device scan" it will change as it triggers the
>>> rename.
>>>
>>> The fix was verified by users whose systems were affected.
>>>
>>> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single 
>>> device filesystem")
>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
>>> Link: 
>>> https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> Tested-by: Alex Romosan <aromosan@gmail.com>
>>> Tested-by: CHECK_1234543212345@protonmail.com
>>> Reviewed-by: David Sterba <dsterba@suse.com>
>>> ---
>>> v3:
>>> I removed CC: stable@vger.kernel.org # 6.7+ as this is still in the 
>>> RFC stage.
>>> I need this patch verified by the bug filer.
>>>
>>> Changes in v3:
>>> Verify if the device is opened/mounted to prevent skipping registration,
>>> fixing the following fstests failures.
>>>     ./check btrfs/14[6-9] btrfs/15[8-9]
>>> Update comments.
>>> Only reregister when devt matches but the path differs.
>>>
>>> v2:
>>> https://lore.kernel.org/linux-btrfs/88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com/
>>>
>>>   fs/btrfs/volumes.c | 61 +++++++++++++++++++++++++++++++++++++---------
>>>   1 file changed, 50 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index e49935a54da0..ea71a2c14927 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -1303,6 +1303,47 @@ int btrfs_forget_devices(dev_t devt)
>>>          return ret;
>>>   }
>>>
>>> +static bool btrfs_skip_registration(struct btrfs_super_block 
>>> *disk_super,
>>> +                                   const char *path, dev_t devt,
>>> +                                   bool mount_arg_dev)
>>> +{
>>> +       struct btrfs_fs_devices *fs_devices;
>>> +
>>> +       /*
>>> +        * Do not skip device registration for mounted devices with 
>>> matching
>>> +        * maj:min but different paths. Booting without initrd relies on
>>> +        * /dev/root initially, later replaced with the actual root 
>>> device.
>>> +        * A successful scan ensures update-grub selects the correct 
>>> device.
>>> +        */
>>> +       list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
>>> +               struct btrfs_device *device;
>>> +
>>> +               mutex_lock(&fs_devices->device_list_mutex);
>>> +
>>> +               if (!fs_devices->opened) {
>>> +                       mutex_unlock(&fs_devices->device_list_mutex);
>>> +                       continue;
>>> +               }
>>> +
>>> +               list_for_each_entry(device, &fs_devices->devices, 
>>> dev_list) {
>>> +                       if ((device->devt == devt) &&
>>> +                           strcmp(device->name->str, path)) {
>>> +                               
>>> mutex_unlock(&fs_devices->device_list_mutex);
>>> +
>>> +                               /* Do not skip registration */
>>> +                               return false;
>>> +                       }
>>> +               }
>>> +               mutex_unlock(&fs_devices->device_list_mutex);
>>> +       }
>>> +
>>> +       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 
>>> 1 &&
>>> +           !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
>>> +               return true;
>>> +
>>> +       return false;
>>> +}
>>> +
>>>   /*
>>>    * Look for a btrfs signature on a device. This may be called out 
>>> of the mount path
>>>    * and we are not allowed to call set_blocksize during the scan. 
>>> The superblock
>>> @@ -1320,6 +1361,7 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>          struct btrfs_device *device = NULL;
>>>          struct bdev_handle *bdev_handle;
>>>          u64 bytenr, bytenr_orig;
>>> +       dev_t devt = 0;
>>>          int ret;
>>>
>>>          lockdep_assert_held(&uuid_mutex);
>>> @@ -1359,19 +1401,16 @@ struct btrfs_device 
>>> *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>>>                  goto error_bdev_put;
>>>          }
>>>
>>> -       if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 
>>> 1 &&
>>> -           !(btrfs_super_flags(disk_super) & 
>>> BTRFS_SUPER_FLAG_SEEDING)) {
>>> -               dev_t devt;
>>> +       ret = lookup_bdev(path, &devt);
>>> +       if (ret)
>>> +               btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
>>> +                          path, ret);
>>>
>>> -               ret = lookup_bdev(path, &devt);
>>> -               if (ret)
>>> -                       btrfs_warn(NULL, "lookup bdev failed for path 
>>> %s: %d",
>>> -                                  path, ret);
>>> -               else
>>> +       if (btrfs_skip_registration(disk_super, path, devt, 
>>> mount_arg_dev)) {
>>> +               pr_debug("BTRFS: skip registering single non-seed 
>>> device %s (%d:%d)\n",
>>> +                         path, MAJOR(devt), MINOR(devt));
>>> +               if (devt)
>>>                          btrfs_free_stale_devices(devt, NULL);
>>> -
>>> -       pr_debug("BTRFS: skip registering single non-seed device %s 
>>> (%d:%d)\n",
>>> -                       path, MAJOR(devt), MINOR(devt));
>>>                  device = NULL;
>>>                  goto free_disk_super;
>>>          }
>>> -- 
>>> 2.38.1
>>>

