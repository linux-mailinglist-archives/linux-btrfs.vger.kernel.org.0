Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA842B9D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbhJMIC3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 04:02:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60988 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238577AbhJMIC0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 04:02:26 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D7Gnq2028774;
        Wed, 13 Oct 2021 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oIukZY4MuTHKvvDLxPNa0BPlUjYWJOwCUMnvu4+ZdIg=;
 b=a2w9OLhgpD/CpIdEHqbXy8kpe4PT8LejzhI8VNYMAOu2BIT2UNBrulfiqx+hg0ZHH5SR
 288EgRVo3O/pyrK4MlG/BU16LDWCAf77IAkjNa4Dus2VnGxE9irkAoONgbgTRpEKJSXl
 GsQ71CLCjfPg2Hd84wL6GTqRe+CPkfgjGUEW4NuBqDVKzR3wKsvoH/EHff6uN5MHReZ0
 5gzbwJYNXU7Sp2QdPuBth4zNXwN7plzkLr9T9ObEA0/YXMziPkOrJkJPVpd7lLr4oHwh
 21lIzomY0TKtu9wejjEpPK69Ir4hS1QcXQdMXt+4xOCFmwpTGcGHkcRXZi63mQ63a7Sx fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbh23af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:00:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D7oRs4156017;
        Wed, 13 Oct 2021 08:00:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3030.oracle.com with ESMTP id 3bkyxt24n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 08:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6ZtJCekBVr4Cz5qUskDFYWNtan4HSGWhH3mDvgtDzIMFT9SdwIr6vTB5IpQs2ESJk5mTGa8cIuut+pB97DShOou9QtVA+2A6rFgnoh570jwo6DveAPEuPyIlGu2lAswjSDHV7tk9dw4j37wj3oJCJHxb1VvNI2r47BxxFkgy6LE3l+s77YLZXCx2qg87GOF1aM5VMdAGUG1Eqx4NVmcURAaTJsiRdOesNcYfi+/MG7zNfVjeup2qH/Uci/UU7JdNr+/6ZQwt9zSqRmB01Xvv+JSTYox30sqdoFgNLwz3FdAEjZ1kCJp+fEzkpHw5lPRxgfDAWRuEp0jyVUFcjA6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIukZY4MuTHKvvDLxPNa0BPlUjYWJOwCUMnvu4+ZdIg=;
 b=TodXEDzviBDm+cHDC/kTDjrNDFdOSNTCA4jl4CFYBNPX4kD2JLU0sAOIViF9tV4VQzAxB+BzhTYaQ4J0V5ZaNz7XbQqrH1IxFONSjZ8zHP5vMPiP4fS8ewYX0oAgs03T1C80oPlarUR6Kn7bSjglwC2Fx5bvItDKSRINgA3yt1XKm5KZdXXKcf+wTnQFAkSRkdJwW2L6f0mHANVMAD9igl/mLEblAwqi+8XZL8ue2aLvVNaJuTpGGN5KLryJNWGGITWYfpB8bXmOztQplxKmbTQ8jhThnP3Hux5MPSAKUxnlSTDYg19KAETa99o+nTjX2cfTSTTzPu9FfSR1nCa7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIukZY4MuTHKvvDLxPNa0BPlUjYWJOwCUMnvu4+ZdIg=;
 b=tuFYS1gonl8AwHnOEbbPw5IzdsN6alIAag85gb/AaYlsj90gm1ZfX8KxC/WENp3KntrGz/3GGmfyA1FWL+/fze/Nh8hfbyzNwjYQ1amd+05HguSO+OVux2Py6zaV/reuiC1jsS0mhFCoq/tPgFoYl4y2M8g81snEJQt5Ig1PvMI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3027.namprd10.prod.outlook.com (2603:10b6:208:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 08:00:14 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 08:00:14 +0000
Subject: Re: [PATCH v6 1/3] btrfs: declare seeding_dev in init_new_device as
 bool
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com
References: <cover.1632179897.git.anand.jain@oracle.com>
 <d0e619aa1de4c142d5b12a41045cc60df0d1c8dc.1632179897.git.anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <6fea27d3-1eb7-4725-b894-1a742d6e5c3d@oracle.com>
Date:   Wed, 13 Oct 2021 16:00:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <d0e619aa1de4c142d5b12a41045cc60df0d1c8dc.1632179897.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR02CA0115.apcprd02.prod.outlook.com (2603:1096:4:92::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Wed, 13 Oct 2021 08:00:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd59b008-c3f3-4c44-7b46-08d98e1f7cf7
X-MS-TrafficTypeDiagnostic: BL0PR10MB3027:
X-Microsoft-Antispam-PRVS: <BL0PR10MB30272FA2F488DF1E243ED9D8E5B79@BL0PR10MB3027.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IU5d6EvvV9Hwyf5QFsCeLMFiJWddTAvdvBygND9lkGuJI2y++ad9soYaHTcJBO8rKg1QDerUjoVPTe7i6RfiQxlb0ZQCRO/n+b2baKuZkYcZegXci7+dxUPKh5ctzFmeEa6B/fMuvwphJKU9PpJluYzcwZh7TbgcWbAAbj+H9n/S0vOrlkMSMQjVsdcjbPGqaJz5P+Jw+61/qDh5Wu2Zot4Ws9gcjUBH5n2OM/Wd7ZnL6q2QNXJzWrkxtYPgTZrk8EOdRUWujalDmMfaCsVSDy7QmnhZOSZCa/Cv+6Ba0JhipR0J5NzBn5qilbp1a3NEL3x7GuXE1gLgc2s/orDOI28DqR5+IGe+eq3YD4oUFkIQyqkJy5kf124AjyBQ5GG4jqpsGDx7vj8eJysAcZta2V99fymkJIjIKkcUlXRV6uC2EO8KCExm6gBzMVr+7X2pjpEaxyHcmAfz4vugQqTvaGCzlWJEPyNcH98gdbwCZcnuRAddbKz8J6iHuiO+QEOBK7kj+ECW45Ahdro76gpOapb9BbmILcTL+RfwPSiMtTxNhA+rpjm4kejBHCK9HHdzKmvLgP3Bwo3eXJV+I0mYIAj891VT0CRDWz2PDRSJ3H63XsppoqqpzX9V3dnxzFdWHsI+tK70MosHuawUZlrGP0MDoBPgVbm6N1AmW2/S2T0MmO3yvEN0glXbr84THTx91Kbg2YAG5tiPcaNUh/2f932K8vVWz3ts9vzx3zsSkvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(8676002)(186003)(8936002)(83380400001)(26005)(2616005)(31696002)(31686004)(44832011)(316002)(2906002)(53546011)(508600001)(956004)(5660300002)(6916009)(66946007)(66476007)(66556008)(4326008)(16576012)(86362001)(36756003)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5hVUxYQWRJSi9LK3VCK2taeFJ4MldDSjZRZnVnd2lJN2lCMjQrc0lDTita?=
 =?utf-8?B?WUVuaFF2UVVzYUhZNEFJdmxiOXJ4a3c4WWdYbnJKaDU1Nzd2bHpISGJpRUVQ?=
 =?utf-8?B?RmRzNlFUTUdJVFlmcUlGQXVxK1Z2clpwTGtTNmxIcnJYTGNveHRpUFBVV21E?=
 =?utf-8?B?RTFISlJOMk9lVHBNcVVSK2FxRk9STHBUVytyVEFwSlRBZkNjaVhTRzgvOVFL?=
 =?utf-8?B?aFA1MUNDbTRmeFM4TUJ4UGV5RmpqL0VLRGFxTnZmOFVoK0MwdGplbklpRGkz?=
 =?utf-8?B?RFcvbXE2V1psWXZQV0dBZG95c3RTbCtaRDdWZnpMM3hIN1laOFRKcTFpa2Vl?=
 =?utf-8?B?UFQrK2FQWDVIMDlJdjdKZzkyK2FUdzFreERQTWM1YlNqeWs2TUp2NllQdGNm?=
 =?utf-8?B?eEpWdjZXWFBjRkk2RHA2Y0llUHFUL054QnVCYVdPQ213d1ZGWUJ2Y0xZVmpT?=
 =?utf-8?B?OTE5Tm5SMlVublJmZFFNRzZHUlg3V3BmUjRKT2hZRU5qMW55bVIzd25QZkZ3?=
 =?utf-8?B?THk2RzY4VzN1c2NsbXhtZDBzQmVRcHBxT3U2cHFQOGo2NjRyMVZFSDM4YzRv?=
 =?utf-8?B?RGdmdVgwZUJTb3k1RG1uNGZrS2RmNnhsTGtsbURiMHEySXZQdURzdnlEbXFF?=
 =?utf-8?B?SlB6eTBDZ2ZpcFNNMUxLbTdYQVpuVUJWSzdrdUJqekdjOXB0NVJzM0ViQUdh?=
 =?utf-8?B?NzhFcWtBTERuS3NqZktnalN5aVJnT28ybEJSYWpDZ1BkQWQ0eDBGYzJZNzVu?=
 =?utf-8?B?RjNMa3pRVXVEaFF3aWdTb0phRkRybS9KaTZqOHNUZXFBZmdZbmMyZ3V1c0lp?=
 =?utf-8?B?dlg5QWVsT1NMOHlJZGNqS0lIc1JlU3RMRWJOTXJiR2JjY3lqWUpEVkFQWGpx?=
 =?utf-8?B?empLM1UzTVRxWHYxdml2RG9JeVVKcTRBZFJ6Unc5MThFNXdZay9oM2NKdkJN?=
 =?utf-8?B?MjVxd2RFTzQzRS9OYk1lN1lScWdrYUM1YllWeG9xSHExS0l4b0ZiSE80cjZS?=
 =?utf-8?B?NWplekc1TXdBME81dDVIUWdabkRZQWRyQ3psc2FEbU5peld1UWRtT3lCU1Z4?=
 =?utf-8?B?L2JtL0JzUjc0RC9QYzR4c201YTN4NEhXN1pPc1lINmEydG45NE42MWdrWnBs?=
 =?utf-8?B?ZjJ4LzRQTm4ydnNJVVJ0a3RKNFpjc1pOaytXVE1CU0RKM0RVMzZLT3lkTVYr?=
 =?utf-8?B?MWdTa0lNQU1EUUNGaTJZWHZSc1FRenQ0dkloc0tnZC9hYW9HZ0VjNW1USXhm?=
 =?utf-8?B?MUUvMldNcERlREhGc1ZJWkFPdCs5M0VDL2ZmczUxOEl3VUpSejBQWlBYUG51?=
 =?utf-8?B?MFVRKytPeHRBaEFKMzVKV3daczhVSjN6QTZpc3BIbElUNmNFTmx0MFIzQkV4?=
 =?utf-8?B?dy8xdnFYRkp1aGIzbkRYSDJDSGdBZEdmRUtIaDA1N0pKM1FtTlNuSVdVeE95?=
 =?utf-8?B?Mys4KzZnS2dvS1Fma01jcGJYOW9XTDVtdkdUS25XN0x6MHF1YUR0MGhLT2Ux?=
 =?utf-8?B?REJSYkIrdHVxa1NRQzIvcFVocktxSEhlMVFGdUpWM1F1ZHF5eXE4cStNS00z?=
 =?utf-8?B?Q2I5cjRMUjViNVphUm5lMWp0THk5a0lhY1RCWmxFUzFJdFN1OEVhcGl4bDg2?=
 =?utf-8?B?aEVwODFUM2VrVFdrWnNEZTJ5Sm1ScUlHSHdVaFpyVXB0d2h1SzNRNElPb1Ft?=
 =?utf-8?B?WVdLTkpncUptczZ0b1JUS1BpTm56SmZMbW5lSUczRDdPMWorR0RzVHhHQnh4?=
 =?utf-8?Q?VkisAP4cQc4N06fuMKgAFaoUlnoGSUM/fJXmcmk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd59b008-c3f3-4c44-7b46-08d98e1f7cf7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 08:00:14.2246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8vANUORzSQQyjuxokucRpH2P6B4IckOUzk1uuERxGHvcq27DMEewNbWGUNVpWMjKXe7uhj2BerIgdX0nYC24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3027
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130052
X-Proofpoint-GUID: tPM6TwvOq3ipbwtgTFv14figBQGPRRq0
X-Proofpoint-ORIG-GUID: tPM6TwvOq3ipbwtgTFv14figBQGPRRq0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping?


On 21/09/2021 12:33, Anand Jain wrote:
> This patch declares int seeding_dev as a bool. Also, move its declaration
> a line below to adjust packing.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v6: new
>   fs/btrfs/volumes.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 5117c5816922..c4bc49e58b69 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2532,8 +2532,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
>   	u64 orig_super_total_bytes;
>   	u64 orig_super_num_devices;
> -	int seeding_dev = 0;
>   	int ret = 0;
> +	bool seeding_dev = false;
>   	bool locked = false;
>   
>   	if (sb_rdonly(sb) && !fs_devices->seeding)
> @@ -2550,7 +2550,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
>   	}
>   
>   	if (fs_devices->seeding) {
> -		seeding_dev = 1;
> +		seeding_dev = true;
>   		down_write(&sb->s_umount);
>   		mutex_lock(&uuid_mutex);
>   		locked = true;
> 
