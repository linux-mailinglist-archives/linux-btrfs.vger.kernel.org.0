Return-Path: <linux-btrfs+bounces-3954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9393899962
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCECB2247A
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CA61607A2;
	Fri,  5 Apr 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEjNDvWN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FmdP+tqe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6F15FD1E;
	Fri,  5 Apr 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309123; cv=fail; b=NBmD02VcPt/MyW3xcpdYpAJaB4TkSJftjsrxzUGMOEx/7Q0QiGEDznzmEL5uekbLb+nSxeRBIULyZXzbOIZHofj26cj4eKY6+cm+GkPFFVLytVjgmDUOqfVKEZUXgVrSLFTU6MlHLldugiUjucJNzuzTGTkTY+VIzI9N1Vnxxrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309123; c=relaxed/simple;
	bh=1gMPVKywYAt04LQ9TAh7hk85Bc+qNT1EYakB6F7kmko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jNBKpv6F2q66P/oieJL5e+x2XQxF/+eDiz7P+T7lVyEp5vIrpggZxOpoYZ6NUDs/Y5bGpCC507huuZ47C8fyuWkSayK/55C7UEcFEV9tQ9kas5hl1TuxCqLsLUy95x6Keylw69IjjDN6EvmTTx29j33QjWt9N8r1ruC/iNhKRjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEjNDvWN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FmdP+tqe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4358YV5k010848;
	Fri, 5 Apr 2024 09:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lB5nvstSEQPfGk0PLcwf7rbJvjwUy9noHaejeV/AVuQ=;
 b=nEjNDvWNJzY08AHEHNnbrTM69CUHmktRButab1VAf9baL5TKUME8FHhQvp1RdKLMaSaz
 sdPvqsLVuOtekw9jYX8h6OydDoNSZaGEDwSVRtQJoEbk7RpDoSAWuBIeSIB8VW1voVvO
 7NnLuFpB17PIQqBbvlIOgLSL6Qpn+eurXjzrtWlxaaEr6Es7/wP+yslC5LOFHjPxbSD6
 V1yYa5QuN/iuiX+l8EjPh0UW6+R1ndABGMrt2H7P8oToAKX2MzsBlWKAGndzf9E0JGrU
 sNFWgH9BUC/T3WgxTEA85JFJqD9ZGjuyMqSZDYg5pUuuYpdJwU+qev6FZFZ7mX9JC61M yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9euy33fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 09:25:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4357WTVC030462;
	Fri, 5 Apr 2024 09:25:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emxvd2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 09:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsNm75wubFc8DMhWynPaIaVt2b2dUGfqbA36UlWBWj4fgwUe6eIwHh5qXD3u6Fhsoankt3un4de/j3HlZ4683DhJlRDj70UYqifhADt7MRnppGuVwI/zWD+5AA5/7FO8kkJPDn6Kibuu7jDftEyiWD/K10+Bd8Tgol1UgarApFbufKCVGWBPvLzv5r5eaOeSSNykggtqCc6gkG53Ng/rjNM/ckXqW7n1OlBUjYLtRVOp28ahwawKEAkgEeN6X+6xx7pqUrdW9b3sezxsTOXXklRjunFar3H0+a2JfzkDcqoiiImGh7/ztiYT6to5HvtCjbQnGU/IEVb1qPHDfVZEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB5nvstSEQPfGk0PLcwf7rbJvjwUy9noHaejeV/AVuQ=;
 b=hq4L5idF0PreEsWQ6cv3yMiEDSkRK5dmZdLRZnBKM4MI9Vw+lfgcmXEDgzUdfQuKg26801UJKlhs9ME/GSB41/08IequnbzfifGFLMat0ml8jMcGXUsu+O16nbG3zTcfHcKFuf5tBPq3mQOOpS4InwGUFt8ixY5w0ySegCookQjfw4VAlVM7POIVQLbID3Fsw+DD+o1iSXF9g+WxLvKdo2w9of3O4LvaaUty0POUZW/5deZIaCzEQu/tyhqk786WFN/kks8COA1uRTzIIoN5L9FxeZ5iQomCYmFhKob45hZQpGlvxZSCbcCP8EHkpGNBX3ScC5C+ii/OE/ndcpu3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB5nvstSEQPfGk0PLcwf7rbJvjwUy9noHaejeV/AVuQ=;
 b=FmdP+tqe78E3qRsBanw3w25AHmYVcCNVTzraVTAoUN81erTkx+TpayW3bj5mg+JN+DBjOW2KwRomskg7b1D4Xw9PtnGo1bZ1UQzykJrNv7edcmmVwqsq1/qDuk4jUENsMDaILVN+dfIq9ulQIhCvadNKrcDRLyXqt4IiO1F901Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7144.namprd10.prod.outlook.com (2603:10b6:208:3f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 09:25:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 09:25:09 +0000
Message-ID: <37e0ae3f-54b0-45a4-b62a-7caca994c38a@oracle.com>
Date: Fri, 5 Apr 2024 17:25:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common/filter.btrfs: add a new _filter_snapshot
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.cz
References: <cover.1712306454.git.anand.jain@oracle.com>
 <3d035b4355abc0cf9e95da134d89e3fbb58939d0.1712306454.git.anand.jain@oracle.com>
 <a62dbef2-0371-49e7-b5eb-9bb5fed32a17@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a62dbef2-0371-49e7-b5eb-9bb5fed32a17@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7144:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bVP0EFKYQv6HLDArBSa4v7t1KqvBO4iKs0tQIjoSxF18LWKIXKSbHJniP3l+1qGeSl9f+yoHHb+Kxx193p1XKK+EJ/XYapc5uvATbg4PYzKKMjs6jFebty8sgGiBFacOEBO3tdQpDwtRkG02SMfwpyQPUk2JkUN30nSLDuXbceeIFpjk3N0xxMl7NGGUhPUxOYgM1sVjioyjMqEJGOv8NCHLiTkNY6AS645x5kCyrRzf43OtJ85qICWQPflUjS7SXO7XOWCpkJ97XHi+ddz745gNoaIii4T6fUQT64h9fmr3yfTPi9SjBYvCX2cF6WyGUHJuwAa0YeNqMdTP4VmiV/5+l/ehGHj2MWI28ehM3DwunTc0ji/KErc/VRBvDWaImwx3PqbePuCW8zrhEOOk/+WoVkzZ86oYOfvdS8Bk3eOhBbG4tuq7oXvWBN5jE6qg8AyZCa4tWs7+xmGw0Lj53bFRFcG6DC5tBsO1/en+UlrNHEGuROrKB3g959jLlVbWzPQDdRkbsTZHWjc/A33H+YUxyoeeV2g8oAL7htK1yy5leKSDnc158gpr8WVTJuItrwkgWpER65pfFp2rQ0mGShP9hmTe6zCaYcQYjI7n9oJanNVMaIKOArl3UGEj8wWRHwITuap9afhDC+dcx4GupgSeh01uqI5IlLohoMRwZB0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUFWNzR3ZEtyYVg0ak8xY3B3RXZESUs5OVBWT0xRVCtOZXkxb04wTG1xU1JN?=
 =?utf-8?B?RkZPT1hMSWNkWCtSVWgxeERXVm1OWENpSi90VE1nWjdKZWVSZ0xMNzVjUWNC?=
 =?utf-8?B?U3Q1S0JvcHpRWXFwL2xmSjl3TitSaEF0RHZGd1N3aTRPUFUwUjkxTmg0ZzdY?=
 =?utf-8?B?ZkZITkZwaHRZT0ozMXNiaWRpSG1BSGpzOUpVcnI1K0dwN0J4MjkvdTBHWlN1?=
 =?utf-8?B?QTdRTUR0NWs4ekxyNFMwazdaQXlyemtVN3Z3aVdsdUUzNDVVdDV5RjVVbjcy?=
 =?utf-8?B?dnY5MWFnV1c4NGZhQU1pS3hNZnoyTTlKM2k4eTlydmdubGJLeExkZWZEMmFQ?=
 =?utf-8?B?b1RmMDlqZzJBOHhTSFdpeG5jL1Q0eDBHM09BbS81bVc2eElEdUk4WW5vTjNH?=
 =?utf-8?B?K1dtUVZTR3FaYzZTdzdMdktlZzFIM3lYcmVvbVdSRnNKeDNEb29sZDhFcTRn?=
 =?utf-8?B?RnB3eEVXUFdhcFZQUjJ5U1NvTVJud0M5SzdrUTkwNXJQUHBicHZNclRYVWlX?=
 =?utf-8?B?ckxMSFg4SitKZDI4SXJwajJoSnA3VUFIYWlraDg1VGl1aDI4ZnZIUFdkRGRM?=
 =?utf-8?B?S2FPZjRKc0NaS3RZd0J4blNSSUtMSWFMM2Z5YVIyR3kzY1dlZVhIWXFwbW5q?=
 =?utf-8?B?dWxxbzhRbTlYTzVZaDdRdUFVZlZ4U25GWXNQd3dZWjIwMnRnUWhTYUszOW04?=
 =?utf-8?B?a21QRE5UMHluTEFaT2xMWjh4MEhiM2pJS3BabDRRNDdDeFY3NHZLQ0dYdmFr?=
 =?utf-8?B?NWpYN3dWT1ozNU9WTlppNk1qRGhxT3pMNVpZTlFPZVMwdWlWbmlCNWxDcndE?=
 =?utf-8?B?cHUxQnJtRkVCbXJEbGdFc1ZZNnRzMkZrSFhjdGhkeS9RV2sxbW1ZdVRvWklR?=
 =?utf-8?B?blFPcEtoMnJKOGxxYzdGYmFaVGt6M2Z2eWlsMTdJQkJUdFVDRGFzWTZmdUhv?=
 =?utf-8?B?KzJuNDRhblM3ZW4vNHRWRUhFM0RaK3VJTXFnalZiOVNTNXNpeks2R2FFc2xQ?=
 =?utf-8?B?UGNJUFBrdURKYmJia2lwZUNsZXNQQlJYUlZXSDRkQWtQM1VVRTc2dWtpUnho?=
 =?utf-8?B?dnBaOGRvS3ZzdVhUWG1BV2h5REg4UEhBTWxnTjBSNUxRbDU5d2haNS9FQlNP?=
 =?utf-8?B?ZUwwYzdFMkwwSGNrTytvOWlheEFQL1NteEdLZVp2OFRTZUsycmNWSUJ6MGds?=
 =?utf-8?B?WTlabDJBUEM4a094bCs1Uk1rUFl2Sk1iaGgzUVdGWk9RQWN5QVhrR2lDUXI1?=
 =?utf-8?B?UmJSTVlLNnNod3ZZaHlRZ3pobkpGblFpZ1UzazJtOUY1Uys0VExKdExSNHdU?=
 =?utf-8?B?a3lrZkc1Q2VZM3lJTFF5YVVzTm1DYnpQWGNucmFKWWhZVllsYnhEamJuWHM5?=
 =?utf-8?B?dGt2emNtWkwwd0UxYU91YzUrTjg5aEM3U0huVVRXNGIrVGc0ZDhzZXJmbVc5?=
 =?utf-8?B?b2FNOW9QdnpDc0xGODlYRFM4dDlyek4ybzlsdUV2Z0JRRXJmUkIxdklicTRZ?=
 =?utf-8?B?Nk1jWXZiMEFKUXZCNEJqbUEremxNRzNIZ2FHOUZ5d21zbVB4cTFQckNzWW1F?=
 =?utf-8?B?S0lteE9HM2p2K2IwZHJhTjdJMHpoOCtGNEZWanM0L0NudENOZmRwV3pQbXlE?=
 =?utf-8?B?eDBDL0lxZFp6TmJvbFljNE1rL0IzV3FFSUxVaks3c2pYTFVwbkEremxyT2xy?=
 =?utf-8?B?c3JtWUdnR2wxYVRURUVRMmVXSytSZG1rRmlpVnplVlQxdC9rTlp5MDM0MUZq?=
 =?utf-8?B?Zkx4THVjN0hMdVJEWjBrV0FSVVF0OUI4K1YyZ3dpQWtUUUhobHlVRUhoTTFs?=
 =?utf-8?B?MkZVdnFvdE0vNFlwb2YvM2RYNU1XczN5U200a3Y3NGJhalRkeUo0MURkdTZP?=
 =?utf-8?B?NVNxUHNvK0JLa09KMHN1SGlkRnhNaTQvcnVtMGY0Ym5zaXIyVHM5UnVHWGFT?=
 =?utf-8?B?NnJOMjN3ZlpwK1ZMZk45ZXBqenNnV25BeEFYeXV0QzNvalRnRTFJajJJOGJD?=
 =?utf-8?B?ZWRYb1hqSHE0WDFSc2F5UjJOT2RmbVgyZ1ZFcWlpSDdFa3ErZFpwaS9Ya1Na?=
 =?utf-8?B?bkg3V01LUUtRQkMvcUFwRFhqd2tBd25ieXQrS09hMS9aR2JUMFJPVkFBZW1j?=
 =?utf-8?B?RVpjTmxSYVZKaG9Tb05oVnpzemhXV2JvYk9rZFVxVzZ6MXhITE9iVkI1L0Ev?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lyqbBHHdcK3hoO4j0zjwub0eNK5q4KTFZAAve37EkG5lf1gWroqmO5eW9OMrgXfjiNRqBf4MsErhXsP/LX1cdqSydzETenwffJAOP+VpVpNABl/0FUHTQh4dBLI8T2nbXLp6E3+a+tlBfDF0lWvOkLIg+DYze8JKtoJmweHkSzxqnKZYy3odyRMkZ5jaDzzzKMjjwPQTQyil0k8nIqFIExRxkT6tkAKdFJ8j5mE0jjFk9DLTeEDu3OCJ5HJ3p/V5yzyljztib64Jyo7jxS3rpCpYdP4BE4Z2wsr0vbE54Tevp634KtJOSe7IFAbWYM5u+3iC75b0zhMvwWNG6sapbGaiLww4JoT+3WJXabJZbaUufD2BZUfE+ybXE3nXkOhrsmzn9hs/kBTyUahHrx4K7qz1UZPvOB3eUJBvtI1IUoqFFwboFXMsvf+qDNnhKj8rdCAAX+qgxKbFui3uUD2xlpVxWhw8bPt15TTTHMiCHQrXGJqKm9QaafbIFjD1UyeYGzOafAIQ3ySbdIO9b699ZP03h/4GzTaiMyekg5vcN5ey/pIeHLRZUztJlmXR1PEo6cSP/fDhU8OQyiUqFPwUUhQ2n6AthjEXi3hHCj8dd5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372f460a-9ce3-4a29-09f4-08dc55524970
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 09:25:09.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQvcvxJZLKIjQcwYr+5KZs6fFvJOIk4t69szzGc84v/POv4S3O8OLkpFYQQmSbhaOmV9JtcIXZmrJrHUgRN4Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050069
X-Proofpoint-ORIG-GUID: qaK5gYd0Yv2JlaIoJTomrSmgmWXT1S3Q
X-Proofpoint-GUID: qaK5gYd0Yv2JlaIoJTomrSmgmWXT1S3Q



On 4/5/24 16:52, Qu Wenruo wrote:
> 
> 
> 在 2024/4/5 19:15, Anand Jain 写道:
>> As the newer btrfs-progs have changed the output of the command
>> "btrfs subvolume snapshot," which is part of the golden output,
>> create a helper filter to ensure the test cases pass on older
>> btrfs-progs.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Can we stop the golden output filter game?
> 
>  From day one I'm not a big fan of the golden output idea.
> For snapshot/subvolume creation, we don't really care about what the
> output is, we only care if there is any error (which would come from
> stderr).
> 
> In that case, why not just redirect the stdout to null?
> 
> To me, if we really care something from the stdout, we can still save it
> and let bash/awk/grep to process it, like what we did for various test
> cases, and then save the result to seqres.full.
> 

This is a bug-fix patch; it's not a good idea to change the concept of
fstests' golden output. Perhaps an RFC patch about your idea can help
to discuss and achieve consensus.

Thanks, Anand


> Thanks,
> Qu
>> ---
>>   common/filter.btrfs | 9 +++++++++
>>   tests/btrfs/001     | 3 ++-
>>   tests/btrfs/152     | 6 +++---
>>   tests/btrfs/168     | 6 +++---
>>   tests/btrfs/202     | 4 ++--
>>   tests/btrfs/302     | 4 ++--
>>   6 files changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/common/filter.btrfs b/common/filter.btrfs
>> index 9ef9676175c9..415ed6dfd088 100644
>> --- a/common/filter.btrfs
>> +++ b/common/filter.btrfs
>> @@ -156,5 +156,14 @@ _filter_device_add()
>>
>>   }
>>
>> +_filter_snapshot()
>> +{
>> +    # btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: subvolume: 
>> output the
>> +    # prompt line only when the ioctl succeeded") changed the output for
>> +    # btrfs subvolume snapshot, ensure that the latest fstests 
>> continue to
>> +    # work on older btrfs-progs without the above commit.
>> +    _filter_scratch | sed -e "s/Create a/Create/g"
>> +}
>> +
>>   # make sure this script returns success
>>   /bin/true
>> diff --git a/tests/btrfs/001 b/tests/btrfs/001
>> index 6c2639990373..cfcf2ade4590 100755
>> --- a/tests/btrfs/001
>> +++ b/tests/btrfs/001
>> @@ -26,7 +26,8 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 &> 
>> /dev/null
>>   echo "List root dir"
>>   ls $SCRATCH_MNT
>>   echo "Creating snapshot of root dir"
>> -$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | 
>> _filter_scratch
>> +$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | \
>> +                            _filter_snapshot
>>   echo "List root dir after snapshot"
>>   ls $SCRATCH_MNT
>>   echo "List snapshot dir"
>> diff --git a/tests/btrfs/152 b/tests/btrfs/152
>> index 75f576c3cfca..b89fe361e84e 100755
>> --- a/tests/btrfs/152
>> +++ b/tests/btrfs/152
>> @@ -11,7 +11,7 @@
>>   _begin_fstest auto quick metadata qgroup send
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> @@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
>>
>>   # Create base snapshots and send them
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
>> -    $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
>> +    $SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapshot
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
>> -    $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
>> +    $SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapshot
>>   for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
>>       $BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> 
>> /dev/null | \
>>           $BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
>> diff --git a/tests/btrfs/168 b/tests/btrfs/168
>> index acc58b51ee39..78bc9b8f81bb 100755
>> --- a/tests/btrfs/168
>> +++ b/tests/btrfs/168
>> @@ -20,7 +20,7 @@ _cleanup()
>>   }
>>
>>   # Import common functions.
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   # real QA test starts here
>>   _supported_fs btrfs
>> @@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
>>   # Create a snapshot of the subvolume, to be used later as the parent 
>> snapshot
>>   # for an incremental send operation.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 
>> $SCRATCH_MNT/snap1 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # First do a full send of this snapshot.
>>   $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
>> @@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" 
>> $SCRATCH_MNT/sv1/baz >>$seqres.full
>>   # Create a second snapshot of the subvolume, to be used later as the 
>> send
>>   # snapshot of an incremental send operation.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 
>> $SCRATCH_MNT/snap2 \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Temporarily turn the second snapshot to read-write mode and then 
>> open a file
>>   # descriptor on its foo file.
>> diff --git a/tests/btrfs/202 b/tests/btrfs/202
>> index 5f0429f18bf9..57ecbe47c0bb 100755
>> --- a/tests/btrfs/202
>> +++ b/tests/btrfs/202
>> @@ -8,7 +8,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick subvol snapshot
>>
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   _supported_fs btrfs
>>   _require_scratch
>> @@ -28,7 +28,7 @@ _scratch_mount
>>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
>>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
>>   $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
>> -    | _filter_scratch
>> +                            | _filter_snapshot
>>
>>   # Need the dummy entry created so that we get the invalid removal 
>> when we rmdir
>>   ls $SCRATCH_MNT/c/b
>> diff --git a/tests/btrfs/302 b/tests/btrfs/302
>> index f3e6044b5251..52d712ac50de 100755
>> --- a/tests/btrfs/302
>> +++ b/tests/btrfs/302
>> @@ -15,7 +15,7 @@
>>   . ./common/preamble
>>   _begin_fstest auto quick snapshot subvol
>>
>> -. ./common/filter
>> +. ./common/filter.btrfs
>>
>>   _supported_fs btrfs
>>   _require_scratch
>> @@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
>>   # Now create a snapshot of the subvolume and make it accessible from 
>> within the
>>   # subvolume.
>>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
>> -         $SCRATCH_MNT/subvol/snap | _filter_scratch
>> +                 $SCRATCH_MNT/subvol/snap | _filter_snapshot
>>
>>   # Now unmount and mount again the fs. We want to verify we are able 
>> to read all
>>   # metadata for the snapshot from disk (no IO failures, etc).

