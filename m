Return-Path: <linux-btrfs+bounces-5171-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBA8CB29C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630921F2251B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80E147C79;
	Tue, 21 May 2024 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iGoITBRw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k0ibYlOQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEE22F11
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311478; cv=fail; b=HF1aIRjfwSnri4pTN69G5dEMkUjffrGVqITma3B/EPJvHLN822qhzAvMaj6JfKG59UMOFblOrvCOoBrfSmIngV2tbvXhHBFYnNC7+eytjEPvso03MW6sv9fS4pgjBbCrbBO9ICZ+6LZHkvREaBJr97vD60umRBuSvEuRsecU4hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311478; c=relaxed/simple;
	bh=6ayt+LP2/NSGJVxrKocfNzZI0w+b/rtbAYklMjdzscg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O038EvJuFr0DUDPVkoTqg/ndVhDOkkzbrQLyXafzB131Hi2W6O3HT/V5t5RFf1xRyebMy+LCH7rHKuKmPOdePZ2UuDzVKbG/JYLOMgwSXzeivX8AyzBqjrIdCAHQzCJx0MumlZujM+NuSV/zwCAzUqMA6IN6y3hGv7Pu6b5fxlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iGoITBRw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k0ibYlOQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGxNLD001561;
	Tue, 21 May 2024 17:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aL/vgf1LgTd7w/dGncY5cMZaLMaj3wHA2CrnPpUbHeM=;
 b=iGoITBRwi8yS1rfkOMCS34KbtXQjSNyLP2JhhgA05AmzAnOOSz1214vsx7+oJnrKpvmf
 GmRh0MVPcmcjA3CAsvounR32zv67rOyjoQQ6XTimjri7tU8+c8yDE8tEzo6h9KKjm51/
 p+ywwShwouFYQK7/EHI7r58JOdBZPuOSzv8Qtyf1R9AKzsyHZl6dJxI8bAw3fRjEIh9D
 CiDYANRvy3+2UzzwKBy7HssCcnt5qjuUKo6ngzJDIjPwCq5qoeJGeS7lZFQW63IEH6Ta
 RTiqCrXNtVtTJtP6TwBudCuTGVoHp8FaWiuh3rdzZ/plPsbxJUuB+ZgwrYuMEEzgZgDo +w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv5vrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 17:11:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGhjU2004963;
	Tue, 21 May 2024 17:10:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js88q49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 17:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+b17VmWihVi49xLwD97yfG8aTqM+/YW+s9gyiVRiEiGbYTcQeU2z4F+qu681I3GQ1x2BJM859nnVoxUrQnj0hDqTiu6nO1ku3559scYR/voZVgHWjZgQWkAJXtQJBUotNIaIpHLStlIk24NUtCyOWVaW5jYGLdz93k0y9W/NQgdTcG977houRT5bMe+ulBEJq75Ni/5qYoMOdkKxgX4po/dIn6WreZy9fOSS9EA1vNDBS4iSQC5zuVLC9DGkVwXt2CxoubvdcQpjyR3f+CCBYgrxf82enzSbeeoFHlJbYOh0SUk6x5hZIswp5mZk8F/wIkMW00IBHA+cGxTtyalLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL/vgf1LgTd7w/dGncY5cMZaLMaj3wHA2CrnPpUbHeM=;
 b=kSWOAWzmrQtyUMb4vORU1KNZNlP6N3fSZVb59aes5hKyPQaLIN20UoVQjWx7GQ9lXqbU+qiAdFaWIVikLpe4+1K7EAVMIOqakB/iC8ZdT6Ncu2x1WU2Az7Yv8gvDLwkpQ5wWiAAx0Tp9/Za/w3c9SVEAWpzO2xHbIPtHqFIHjaa5bAsVVMnKPMZQhsvRs5V207CRkWQ8lAoaGEbnCfbJ8ugisnlolUk1kSWtLImZvxgfi5KLdFO6035IPhy0OcxixDIOpJyxKzQ+ACCyDt9vFLjw51pvbXSdqIVr2YylG6vx/lCh2xdI/KKeUYW9HIGtRTfnYXkICHYrnkN4cIDKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL/vgf1LgTd7w/dGncY5cMZaLMaj3wHA2CrnPpUbHeM=;
 b=k0ibYlOQ3eRk6B5r7W/hoqfOjCTkBGvn6caN6XLsLC0vxkDZ1QObzpl7rLlXD8k8LhKaWZ2CLs4mtrnJvLIQ7usobsZwh2NvttnAXKaXUhwVE0kvH4wclGVPYPbwrsEuqukO1L5nQkpqoh23DOPd/J5VWwHMpOjCraiIrZC4fV4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:10:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:10:54 +0000
Message-ID: <58fb580d-160d-40cc-94de-cecf97faed74@oracle.com>
Date: Wed, 22 May 2024 01:10:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] part3 trivial adjustments for return variable
 coding style
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1715783315.git.anand.jain@oracle.com>
 <20240521152120.GQ17126@twin.jikos.cz>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <20240521152120.GQ17126@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d9157c-6bfb-40d4-2faf-08dc79b8f96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Sjg1T1VCck9KZVpqQ3lOYzlGTWo1aVRJOG9ZNXlyOVV4MUkvckl3eXpyR2xE?=
 =?utf-8?B?QzRaUEpnc3A2U3VqRWgyQmhRM3pId0xTbkNsSFRZWVZra1dPNkpqbGlyWnpz?=
 =?utf-8?B?TFAvNDNmT2RFUTh3dmRTVm04M2hIbzloWUZ2dTU2djAycUxHbFdnSDErekdW?=
 =?utf-8?B?aUcxNFV0MFlvZUZmZTUvUjgyUk05enV6ekczaVlORkdvcGw4UFVkNE54b0lz?=
 =?utf-8?B?ZW13M1NZS1o0MENkL1B1YlUzOWRXL2ZOZWhpeDgwbi9NMEhoQlU0elkyMDJz?=
 =?utf-8?B?dnlaQUFMU1c2bVJMOUpHN09MTVNQOXIyOTA3VDltdkk4NEZ1cG1XcmJPNWhp?=
 =?utf-8?B?ZmxDQTQ5QUdVdnVBOUtidkFqbHg2V1ovMmNnYW1USktxM214ZWhzWVlWWXFQ?=
 =?utf-8?B?dzJaOW5LQktTYkRqbWFkejNLWWxoTDl4cHU2UXFFekJOODMvUU1WRTlmblJL?=
 =?utf-8?B?M0NBY0tsVEpyVlBxM1NIY0E1WHBGZU5KVFY1S2FaYWVQbG5XRWdKUkI3YitH?=
 =?utf-8?B?eGhZaE5uRSs1dnBhQmZ5b0pJbnBxbTNtREtLRmFnRkt6ZUZZQlZtRUZ4S3la?=
 =?utf-8?B?T1BQWHA4bnBFcEdGVFZQZ25xdHZ4RkFhVW1weVlHTGZxclZWT3Jpd25hcUhO?=
 =?utf-8?B?U2lIa2xKNndZUkh2em1pRk5DeDU0TklrUW1zRXNZWW1rdnFYTjd2OUtHNjRp?=
 =?utf-8?B?MnNsdHVRUndvaXIrTm02WEd3RFNMYWN4ZHdmdkVlazhKUFo3UnJnVEVLdlRK?=
 =?utf-8?B?cy8rOE5aemE5VC9HVndFeE95RUF0MWJwbDVOQWxuM2U1OFdrY0hpcWh6cTNi?=
 =?utf-8?B?WjhyRnQzOWt2SGVLc1grYk5Bb21DaXVoN0Y2RUs1MnRabldDM0F2N1JQQ2h4?=
 =?utf-8?B?aTBMWGoxMUNlb0lqbTNObWtsTFBDSktUNWpmNDZVRGdJbHlPOUh4UjZkamNp?=
 =?utf-8?B?MUw2bUl1WGpDZ3V6YkxKbEZIbmJqQWNad3pySFN3ZFBIRThtYXZQRUxZQmtT?=
 =?utf-8?B?U3hzdENYbzFHa2NiNFpTUHZ2VUNxWGlCSGU0MEs5djRSbmpHQ3NpeGQ4UjlJ?=
 =?utf-8?B?TEVDZkhsMFN2OEliNHJDRnNlOHlGWVRpeEZYVWRBV3hKRHl5ZkRyWEgydFQr?=
 =?utf-8?B?QVBwTVNTVXNuVzZ2QmdRRGRiRWRmUFZsRXFXV21FYk03UncrcDNRSXZwRkc0?=
 =?utf-8?B?VkRYMHhiL2REbVZ3WUxZaEhqRmdxeko4VWw5K1cvekNxdnp6aFd3UzNiQzY5?=
 =?utf-8?B?N2F4U1h4c1VKKzJUOGxpZ0Fac0M2cFRNYWtjNDA4WVZvT2wyRkQ5YnpHTjhU?=
 =?utf-8?B?TTN1bFRhRVBCazE0bWJMaW5UZkdLMEsxVHlpR0tBS29lek5hOTBvMFVlNStv?=
 =?utf-8?B?eW1SekVJcGltcEp4bENZTGRhZlNseXlWV2dhKzNpam91Y3EyVzFmY09hejA5?=
 =?utf-8?B?d29JYmxFM0RFblBTamlnQU9XVTI4OEFTNG1sUWZjenJaYTF5OU5oQmNWcW1E?=
 =?utf-8?B?TFQyYlkxdVBON0FMREZsTTIrNUs5ZmpQWTRuREhoT2RlT2k3Vzh6YnZWSDM5?=
 =?utf-8?B?RzJxR1ZOUGkxMzU0TjVGK3FLUG94NGZrSmU3NVRwK1hKSFNJei95SGkzazBv?=
 =?utf-8?Q?Iq1lRpG2StZp4tzObVYA3H/wpX/JquNaP9GJs3bip31s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXZ1eUF2VHh6bnpQOVIxZWpmYktSL0taa09xeGE0VEM0QStldzFvejZlVjZB?=
 =?utf-8?B?bzd5S3pQUkhJck9uRHE1ZDNsUUNCdncraE9zTE9HdC93U1pFVVZnNzdzR0lW?=
 =?utf-8?B?YnRTdGRaWUpqMmh5M0oyNCtXaEJaT1BXTzd2elRFWTI5T0VWWkQ3RFVDQXh1?=
 =?utf-8?B?dU53WEJjRmozdnErYkhmMlhkcUNiU0IvVHd3eFhjNzlwK3kxc0pEUmV2WU9j?=
 =?utf-8?B?ck1zYjREQ3hqc0RQSmIvWFlmNm9YUU9jMjZpN2VpeG9sM0EyeHgvWjIxZzFl?=
 =?utf-8?B?QU1nbGFqZVFSRXJvWEQ2M0wydXprK29GQW9mQ0o0UUpiUnZmZVNmc2ZGbHhJ?=
 =?utf-8?B?cGRsM2poMHM2eDZ4NFJkTk1kdXViSldJcGo1WStZU01BOU1MWDI2YzIzdTNq?=
 =?utf-8?B?Qk4xbWkzRXRONWUwRmlDU0JsdS9hOFBWeDhCYmxmcUczWWxQTFB6a3c5Zy9w?=
 =?utf-8?B?OUxrT3NBTmg5eFE0UFdYNVlxK1ZpUXB4ZExIUHFqTVF5RjdnSTNRU0MzcjNu?=
 =?utf-8?B?dGM3SmVHZUg2azF3dkFBM1RaVWJxdGR2MTBnWU8wbS9OVFBPcXNRdThwN3hk?=
 =?utf-8?B?bzUzQXBmUng5ZWFmVnR0NnV6cytOWjlzWWJSZFNZa1Q0R1NyV3BmL0JkbkRn?=
 =?utf-8?B?aE9qQS9kZi9ZUWRiQ1liRGJnS1M0Y04yQ2M4ajRpUElRZUxrd3hnNlE0NGM5?=
 =?utf-8?B?RGhUZk1sQXpOdjF4UW5sbUtEZFVnVjNEb2JRS1pEbDR3RktlS0s4c1ZLWmZz?=
 =?utf-8?B?Sm5lajdOUnJHMUIwS1pZM3hsMmZIaUNpMG9wTmNkSWZ6TjFzaHpEdWRlc1E3?=
 =?utf-8?B?aTEzT1cvQ3hJVTJQSHcwU1BUZzZNUE92c3F1bGVCVkw5VlFvNWZnWUg4WDE0?=
 =?utf-8?B?RU55cVNkajNHSlNrT2FVY3VuSW42YkZzdzN5emFCWERUS2U0c3dIOVBFZ3Vp?=
 =?utf-8?B?Q0ZoeUFzczYrMGJRL1NDK3FPT0dCYVJLOHhsVHVnVitNVXkyaDlUZXkyZ3NG?=
 =?utf-8?B?WHI5bGx4L1pRM0FEWFcrZ2w3UmJqc2U1elJIMjlrNkJSRHdNUkE2Yi9Sem9s?=
 =?utf-8?B?TExjeWdPTEtONWUvSUlCbUpucHQwSGdOcUxqVDdXZ0pWT2lTbkJ5azI1OXdr?=
 =?utf-8?B?UjVOYjYyZm9SVW9yNzh1c28zRURzZk1HeXA1dTRxSHZhbWhyNmE1QWR6NjRE?=
 =?utf-8?B?TWtubzFPaUd6ODlFcktPd2RGWHFpeVBlZTFMNEpicll4U0E2aDk5ZzkzMUhv?=
 =?utf-8?B?UGw5NUN2ZWV4aXp3OHFNcXh1THFPOVp1aUZxcjgvS3pyL1h4dnU4cFVUTXhM?=
 =?utf-8?B?R0pqd1JUVjF0K01Oam5MUEwvd0JoNWZNUjRZMTNwRUNzY0V6a3NKcVduWVZM?=
 =?utf-8?B?WUFvNVFkc3A2Vkl2Zm5UdFNrNEQ5b2l0ZnB3RVVQamVDaVQ2SllwM0Q5ZVdj?=
 =?utf-8?B?WUhOekpaMFRVMzFtNlpDTGRJQXR0aEhaQjR2NkMwOUlmam9VbzBrRVFnSitp?=
 =?utf-8?B?SnUwd0hhSFNvSzNHQzRxdEdGK1F5cmhWbGdMTW4yTHBUT3IrRXIvL29yOVFa?=
 =?utf-8?B?OHRwb3pBbnY3eFhIbTBOd1FJKyt5emtRMmRxUGZzcGZ2N3M1V0lxNHlja3pM?=
 =?utf-8?B?cGpRZmQyVTdBQjdTbWZqRFMwaEMzUUJoNjhRMzMrM3dnczNhOTVyYU43VzZI?=
 =?utf-8?B?dzMxWjNwdytqaFlEUHFBSk9vYlVzdFVhNy92RStXeDhMUHFYK0NaN3VzQ0Z6?=
 =?utf-8?B?M2NhVm1QaHFJOTdiYXZQSThQbUQwdFlWbjYwRnpBS0paaXladkN2OWZjSnls?=
 =?utf-8?B?ZDZoS0pVZGp5K1cxV09NMTduR01FeGNlRFdldjZKKzZsY0tlc3RrSHJWRXBB?=
 =?utf-8?B?MFMxNTljZlBTd0VZcndOQndkN3hOcFhHSnhSanBjT1lDSkdtVmZzZHdHaVZK?=
 =?utf-8?B?R1cwemRieUt2UHFDUzM5dHhoeXhBUFdsMklXRW02d1lMSmdQWjBsalNQTDBp?=
 =?utf-8?B?eWh3em4xYVlzbUc2OFovK21LSHVXdTF3MjFhdXRvYklFT1Npd29KTVpGRG5D?=
 =?utf-8?B?ZFRaSzJPNzJIOVNpdTU2Z3dvNE5DeXYxbDlmemhFNzZFbGNTMjRncDZ0V3ls?=
 =?utf-8?B?TmFaS25DRU52Mm5yWkVIVUg3NDBGaWM2cktiMWZscHR4dC9mMTNvQmpwaGdQ?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7bsn7wL/mvcQN8GmuBs7hJjlqB9xSj1zX+wqlG0yofPKC5vKcgpSKhP/1gzxu4bS87lYoX7bb/KL1fk9JEOFxd55bHLaIsQQBqHLfR41eRuxkQWY+uZmhq8n0Hk2ejKzj04jDdZ96oG7XVdssM11O9e7r4/eibpTfKwvaCghk7J78w6tTjY4O4LiSlraakiSeJcOnRU1IGYYxUspFB353qcdN0EJdfu+r0EAj/wbPR9RTc1bhMw8N5Vb3KjSL6pDkn/Q35m3dbbsSoPUP4x2yZBGW1wleeBt9WLnGgZkBTg2hKSsym8v+NjSJcqAGAW5Y1t1/llNky9QjugvZL1klpNBNM6ztOFzAeHAkgOTBBVTbP8Gb4AsOYCmK5ISWkAtHjwN61iwK3TRrhRsiKsvnOC9WooXppNRraVW/VJOxvz79b72ddEM+lNWjgkWZ4nnUO8y8avUCIZuImWmQQiGOjpphAJxWHMo8tTvv/A2G/1qP6hS9FIiASRzSN8uP7MSWiEfdeCPVyhQ5baYts5iQMovBkei9EUPPjdyiL+SNG9WHJjF39RXVQmkdEliwqHKOG/iKLUOuu/Q3OTY0D/CcAbbFm/B6TtYZ/yulv7gd7k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d9157c-6bfb-40d4-2faf-08dc79b8f96a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:10:54.6317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJiZ59MoZNPl2jWGT8yCRi/SQaMVzEDEVDN9ElCadJt95grUX7szbFd+H5q/lRbvjvBUv4C5oXRHbp6AjHhXeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: vT0mZ9tfVS3NgC4xP8xuaJljKh-8HxHZ
X-Proofpoint-GUID: vT0mZ9tfVS3NgC4xP8xuaJljKh-8HxHZ



On 5/21/24 23:21, David Sterba wrote:
> On Thu, May 16, 2024 at 07:12:09PM +0800, Anand Jain wrote:
>> This is part 3 of the series, containing renaming with optimization of the
>> return variable.
>>
>> Some of the patches are new it wasn't part of v1 or v2. The new patches follow
>> verb-first format for titles. Older patches not renamed for backward reference.
>>
>> Patchset passed tests -g quick without regressions, sending them first.
>>
>> Patch 3/6 and 4/6 can be merged; they are separated for easier diff.
> 
> Splitting the patches like might seem strange but reviewing the changes
> individually is indeed a bit easier so you can keep it like that.
> 
>> v2 part2:
>>    https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
>> v1:
>>    https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/
>>
>> Anand Jain (6):
>>    btrfs: btrfs_cleanup_fs_roots handle ret variable
>>    btrfs: simplify ret in btrfs_recover_relocation
>>    btrfs: rename ret in btrfs_recover_relocation
>>    btrfs: rename err in btrfs_recover_relocation
>>    btrfs: btrfs_drop_snapshot optimize return variable
>>    btrfs: rename and optimize return variable in btrfs_find_orphan_roots
> 
> I've edited the subject lines from the previous series, please have a
> look and copy the subjects when the kind of change is the same in the
> patch. Also use the () when a function si mentioned in the subject.
> Thanks.

yep. I have updated the patch titles in v4.

Thx. Anand

