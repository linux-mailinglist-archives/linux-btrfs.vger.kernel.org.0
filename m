Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB90D3E147E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 14:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhHEMNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 08:13:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45352 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235505AbhHEMNo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Aug 2021 08:13:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175CBkgq006228;
        Thu, 5 Aug 2021 12:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3Aa1R3MWOtfWhaBMU6IdttYozYAL9aqN5xp4uYBTJPs=;
 b=ITNBxFd4VB0nfbeDg0GQ2NYSXvpYUzs7gzRnne98wsGPZSN+y3vTIV6V0AEw5LPUk9wz
 dvoJNqfLHm0+0/JtPuEok4M50m/s96Ty2P0ZKX4MlrneDk4VvCzonnQeEpJPZwGwlA+W
 MFpz5XjTEKMKCkiv+T0HVFVm/k8B4Zqj3xU103GRFzuHAMtJ5sUow2m/hAhpCDcyhMbI
 aqF4sL58hUOk3uCLdKQQWjnsZXNK2X+r3BicMNA7aQgxGfhMqDZ6gT+kyfDr7sbIEr7W
 xdh2m26zUB3l3AQut8Qxtn6GzV7KH0YgoEywe8nfBaeaiq3gDSk+EQpCd+AVtFm5Kks+ hQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3Aa1R3MWOtfWhaBMU6IdttYozYAL9aqN5xp4uYBTJPs=;
 b=tXaOAko7BoqmFHfkZkWa/E4hlS+jLloK4sKza8VZK1ia2HjKkj8lFwMx0VbWliSfXWNQ
 aru4aNA2cvc1/XJofrSeFE4/8cXFaySdwNHrBjhtiBh53cUJLoc/e4EyeTpKtBZuWkt9
 Wpemqtu3oCgTgSoOA7uMBUNITiplraUFCgeAl8RC9nupbDEpRNHRc40qEXCTDafGEA+M
 opxkqp4hdkZrMHSyR2ZHatVemnqTXkeOqGJZdr1Sp4vgHpiMiDRvIa+gvnxDNw3csgJU
 H2brjQogpHwHyvS67jUSRijLVo+JDxTeYeLfAZIB1YCNRffF/WX30oBdE1OQqXX7aINa TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0cgj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 12:13:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 175CCFOd091226;
        Thu, 5 Aug 2021 12:13:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3a78d8h1gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 12:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZil0i9Q2aqO9+eqjmWKYq2RViiiw7JqbYjk2Ms/f3HMiyVYWHvs9qpkI9MK9CGx1ESfByNOWzGw+LzkEymDs7FIO43fDlm7uKj3LVyY9kSz8LfJ+tvg237YY745jwQEMsbhYiwsviD7W75bQrnpUmCuDWSQIsoi1wdZVHGQdR+mMgep7mJf/WuG6FQp/+B7PjAypUVj4q7nVjmUKu03YYNZXILoTbPUg8OtI4USgIECkBfxTn50rUsnT47RtWE0Y478mwDEHlRp2jqPoxvgl8V+LdSLA6QsrYc8k+2oYFsaaG+fnGc3C0Ymzi6FcaYg/y93mibuQ88AuyQpywH5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Aa1R3MWOtfWhaBMU6IdttYozYAL9aqN5xp4uYBTJPs=;
 b=NU91B8waV/OWFcGxDF2njcL0x9F9wGNZAqN3ix3O6bqEmyerkX0EsqxF9uWKDuQoKva818papOuim5KOKs37Nh13edxmCm41yWLXwnxKFasO9XIcEzxSRUdIz0XaBG4/qUcpfMnug3T+8bfuRm43QaSEAasgKmNXVVq5daa2i1iY20o3i7HgA/TAaokMxxN5GlYPz2tfZl2n3qmWvBFf30zGsqpaHPCPdL0G6Hbl7dMlm2ipChvlgsLnrUEl2qDsqOhsHYMKSiwuEnPcDwkwM6iklTAhAUMmbrzl8+ecxclpXPuHB6t8Vso2BxhdtyNt6rx9VFrVXmV84Llg2GJPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Aa1R3MWOtfWhaBMU6IdttYozYAL9aqN5xp4uYBTJPs=;
 b=Wc8n4+hZKc65muI3x5RxZBOkk/jeKQ5tCCHzBbtGJGbAyBarjkUOArISWlmkq78aB0qP4EeV/1U9iGFG36E+VAXT9UP+i8sxscIBYwP6LS2/ZM+sqdQH0LId3aQVJq4yS3YElGZlqJZ7F/O3GBp/fajXEXt/5GKHh/Bt+7PYQCw=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5217.namprd10.prod.outlook.com (2603:10b6:208:327::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 12:13:24 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:13:24 +0000
Subject: Re: [PATCH 7/7] btrfs: ioctl: Simplify btrfs_ioctl_get_subvol_info
To:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
References: <20210804184854.10696-1-mpdesouza@suse.com>
 <20210804184854.10696-8-mpdesouza@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <8b887a24-b676-360e-4cc1-d0dc0e0a0b19@oracle.com>
Date:   Thu, 5 Aug 2021 20:13:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210804184854.10696-8-mpdesouza@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 12:13:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18be9639-b2bb-46af-4232-08d9580a6c10
X-MS-TrafficTypeDiagnostic: BLAPR10MB5217:
X-Microsoft-Antispam-PRVS: <BLAPR10MB52175ECF97D102147427A0A0E5F29@BLAPR10MB5217.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VYUhv/rWmVytuhi/RN6oJG7Rtff20rWZNFyENlJBxPhFnzA0PfbBw+d6tvEXaUefZeJywq0ImfjJvvKpmgqrtt1FbwAeoa/01YvWQdhYSR+PxyEfM3qLVzbeLqL3qxaGRjRWhJGdlfDEFc6xQ9lfb7BE5+K9/nmSBrgJLvqgoGk6q+//LIT/2LmzmHgWBaAV+pK5/bXPQSmqCPylU9FirsgVsM9mmy7rfazJN55dKYnoqybCffmslifb1BQjlQMuJ31JWs/hGAcdsu1tCC9bGzRq5H/uYJNApSGFEyQJRiYynmKnyrihZOQRi0zLndK1RVRZ7pNDS9rp2cBhZwTyZRnw4KkYuY1OK/8ps9iP/LPen4qtvJqGWD746xosTS7o99GGPKQcN1DGiRod1qw/NWtji1l7Nw5nbJ1jB2MFBORAPNpkCrftUAmkGmCLWsG7MVudUpQKa0t5Gwvjxt2qSu9eYZHaCdRBRdhHwoTeAOIzZl8yRvBEj9CpipMIg5epO1+m+hvfYPAch8Rv2i7T0M5ScePCk5hho2jxyyW0gc37RMlwDUEitPvfUnbGOxNYZ1+B505fZL9Kd+eW0KEx4MDDcqdhMSPlfyUrTFCUE0L3nzCN+GnpjMBJeTq4KS8gQHupyC02CNQJvCieHfl89QYfIXUh/NA/h5PE+ShSYk4lqZv4lcHZ6Evymjy6PPtUB+XyAkZpfL6++vmcLw5z8HmuJWzgfME7EQ0dL1QbcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(31696002)(316002)(6486002)(53546011)(44832011)(8936002)(4326008)(66476007)(86362001)(66556008)(83380400001)(66946007)(26005)(16576012)(2906002)(5660300002)(38100700002)(956004)(6666004)(8676002)(2616005)(508600001)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGFjNHJ0NVJUWmcxZDZNOXhhZEJCeUJnb3RiK2g1TjJBMWYzYTVudHd1M1B5?=
 =?utf-8?B?WmRIUlVkaEZuTmRUMVdxNnBhdnNZQmYyRFhjbTA2akIxSU1iaEZzK0FjODFR?=
 =?utf-8?B?dktWeXorSklvdzBSR2ZXa3U5ME80bFdSWStmTk9jU09VMHBOczVZQXNTK1ZK?=
 =?utf-8?B?MUkydmRrV3o1eGdmbTIzdEI4QU5kb05DaVRSdUdadjRNUDQ4dzFOYnVpZ2pB?=
 =?utf-8?B?c3RjRjhNUTdHdzVDam0zdXVkL3hLWER2KzNJaDA3RGxQekhjalYvNVB5T0pL?=
 =?utf-8?B?b05kK3ViU0tSUllUSVQrdm8xQWh6THFIb09lZHpNdWdiU284Mm9YQnl3L1lx?=
 =?utf-8?B?WUY3Q0xMUjM5VDFsVk5ZYXRqTGJUTFhXSXZxVFpnbDFiMlA5Q0VPaXZGbm1y?=
 =?utf-8?B?Ym05dnJIYThqWVBWR1kzRSttMU9xR2I0UWVFM290RGN1QTdaY2xnNUJOeVJk?=
 =?utf-8?B?cy8zRmtHN2lONWd0VUdlQnVKdjVRSWN1Rm1UTkpYTlV2UCtvMWY0c3htcEVS?=
 =?utf-8?B?c090Wmkwd0gzdlh3djdKMzBXRUhuN1E5WldYbHlzd3ljRWt3ZlY5dTZKQXlB?=
 =?utf-8?B?dlM0d09zWE1KU3FYUEFMM09YSzN0VE1yUUM2UTBsS1VJNzlkajBJQnhQM1Er?=
 =?utf-8?B?aTBqcUtqSCt2TUdBb0hyOE9QQWlpRFpvbVhOQ2xOYTV6bi9lakg2dFBLMnNM?=
 =?utf-8?B?VDIxUDJ6aWlUdVdXZmFINzA4a2tGbTFEamlNQnQ2RFRsMWVGWjN2bCtFWFlm?=
 =?utf-8?B?d1pxK2g4R0FLM2lnSTlCTmpxUGZYTVN3MUtoMm5PSmZNbEdnY0JSYytqS3pi?=
 =?utf-8?B?NUhaSFVKNUs3aW1ubnhNSGRQV0haYVZwVmJTQTVlMng2V09iRHlJdFhybDNO?=
 =?utf-8?B?aysyRy9GVi9mS20xb1NxVXN6bW85eklxRXZzVzljWnZ0OWNIL2F1MWd1ck5N?=
 =?utf-8?B?S0VQNzRROWNGa0k2ZGg5dHN1Z0FkSlAvZnZQd0xTZDUrNU1ra0YwUmZTaHp5?=
 =?utf-8?B?TEgraU00Y0dXYXUrbGFVL1B2MUhMK0t5WXVmakVHTzhvSkZ5ZTVqRmRTdFpv?=
 =?utf-8?B?NzlBWTltYkpZajUvbG8vSUROQXFPM3NPMGgvT2d4VzMvaHRzcFBkODVKS3Fm?=
 =?utf-8?B?ZFJhWG5UbGxMUUhzT1QrSjFXNFBWeVJIMVlzVnhhdnRxaWNjK1haS3VaYWJk?=
 =?utf-8?B?WkRmeFNrOTQ2ZWdMb3JYV3hlRUlEM2FObjUvc2JMYjErTUlVK0NzTmJjNnd2?=
 =?utf-8?B?WStjV0s1TjNERlZ2cXJXa3FlMTFPQkpYRFYrb1QyTlVac3duQ2ZaOVBrbG5I?=
 =?utf-8?B?MHZkbStXczFkemxwZjh6YkdDSDd1V3BTOEVuWlFQZmY4eHRQNkdXdDRtVFlG?=
 =?utf-8?B?MWg0OFFEQWZJaE5GcVF0WUpZRGFQMzNGYVcwVXdneFRsVEtDQWczRmFmSzJU?=
 =?utf-8?B?TnR4MkZScjNMY0k4NFdWMlJiQnFLWGx6TEc5US9CcE11ZXFmUm1uMXhRdCt2?=
 =?utf-8?B?NHUxbm1WMkZSamlBR0NsbFJwZzZXV3NMZTRIZUF2aElPbTYxRzZJWmlXZElM?=
 =?utf-8?B?ckFpS3FZazFUVXNCbEpxSW55SUhnWTU2V1NOOHF3ZE42dUVQMElzSnNQWm5H?=
 =?utf-8?B?Zm5KTVVxUHhrR2ZCdFJrY1VaZkJrN2tZWTZONWR5K2prYllXQmROZjFUSE9H?=
 =?utf-8?B?eWxFbE15N0s0RytJZTl6K29UVjFVb21aaDh5VERIU0pTdVlxSUI2cVM5ZGhC?=
 =?utf-8?Q?93oZpTH3TbNXAM0N0EMzuvCtIPOaRzZlKzl0IY6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18be9639-b2bb-46af-4232-08d9580a6c10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:13:23.9789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYSnb77AXEecsrNAK/rExFOXrGapmY9wPiJrCT1aUjLoXhoN/CisIsVb7nosAjCy3PnwWsvzMOQo6yj4d2lkwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5217
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050074
X-Proofpoint-ORIG-GUID: -5ZMqoUGZaEvGZcTAUjlozdW3hXLPBRE
X-Proofpoint-GUID: -5ZMqoUGZaEvGZcTAUjlozdW3hXLPBRE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/08/2021 02:48, Marcos Paulo de Souza wrote:
> By using btrfs_find_item we can simplify the code.

  Yep. I like the idea.

> Also, remove the
> -ENOENT error condition, since it'll never hit. If find_item returns 0,
> it means it found the desired objectid and type, so it won't reach the -ENOENT
> condition.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

  Looks good to me.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/ioctl.c | 56 +++++++++++++++++++-----------------------------
>   1 file changed, 22 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d09eaa83b5d2..2c57bea16c92 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2685,6 +2685,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   	unsigned long item_off;
>   	unsigned long item_len;
>   	struct inode *inode;
> +	u64 treeid;
>   	int slot;
>   	int ret = 0;
>   
> @@ -2702,15 +2703,15 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   	fs_info = BTRFS_I(inode)->root->fs_info;
>   
>   	/* Get root_item of inode's subvolume */
> -	key.objectid = BTRFS_I(inode)->root->root_key.objectid;
> -	root = btrfs_get_fs_root(fs_info, key.objectid, true);
> +	treeid = BTRFS_I(inode)->root->root_key.objectid;
> +	root = btrfs_get_fs_root(fs_info, treeid, true);
>   	if (IS_ERR(root)) {
>   		ret = PTR_ERR(root);
>   		goto out_free;
>   	}
>   	root_item = &root->root_item;
>   
> -	subvol_info->treeid = key.objectid;
> +	subvol_info->treeid = treeid;
>   
>   	subvol_info->generation = btrfs_root_generation(root_item);
>   	subvol_info->flags = btrfs_root_flags(root_item);
> @@ -2737,44 +2738,31 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
>   	subvol_info->rtime.sec = btrfs_stack_timespec_sec(&root_item->rtime);
>   	subvol_info->rtime.nsec = btrfs_stack_timespec_nsec(&root_item->rtime);
>   
> -	if (key.objectid != BTRFS_FS_TREE_OBJECTID) {
> +	if (treeid != BTRFS_FS_TREE_OBJECTID) {
>   		/* Search root tree for ROOT_BACKREF of this subvolume */
> -		key.type = BTRFS_ROOT_BACKREF_KEY;
> -		key.offset = 0;
> -		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
> +		ret = btrfs_find_item(fs_info->tree_root, path, treeid,
> +					BTRFS_ROOT_BACKREF_KEY, 0, &key);
>   		if (ret < 0) {
>   			goto out;
> -		} else if (path->slots[0] >=
> -			   btrfs_header_nritems(path->nodes[0])) {
> -			ret = btrfs_next_leaf(fs_info->tree_root, path);
> -			if (ret < 0) {
> -				goto out;
> -			} else if (ret > 0) {
> -				ret = -EUCLEAN;
> -				goto out;
> -			}
> +		} else if (ret > 0) {
> +			ret = -EUCLEAN;
> +			goto out;
>   		}
>   
>   		leaf = path->nodes[0];
>   		slot = path->slots[0];
> -		btrfs_item_key_to_cpu(leaf, &key, slot);
> -		if (key.objectid == subvol_info->treeid &&
> -		    key.type == BTRFS_ROOT_BACKREF_KEY) {
> -			subvol_info->parent_id = key.offset;
> -
> -			rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
> -			subvol_info->dirid = btrfs_root_ref_dirid(leaf, rref);
> -
> -			item_off = btrfs_item_ptr_offset(leaf, slot)
> -					+ sizeof(struct btrfs_root_ref);
> -			item_len = btrfs_item_size_nr(leaf, slot)
> -					- sizeof(struct btrfs_root_ref);
> -			read_extent_buffer(leaf, subvol_info->name,
> -					   item_off, item_len);
> -		} else {
> -			ret = -ENOENT;
> -			goto out;
> -		}
> +
> +		subvol_info->parent_id = key.offset;
> +
> +		rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
> +		subvol_info->dirid = btrfs_root_ref_dirid(leaf, rref);
> +
> +		item_off = btrfs_item_ptr_offset(leaf, slot)
> +				+ sizeof(struct btrfs_root_ref);
> +		item_len = btrfs_item_size_nr(leaf, slot)
> +				- sizeof(struct btrfs_root_ref);
> +		read_extent_buffer(leaf, subvol_info->name,
> +				   item_off, item_len);
>   	}
>   
>   	if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
> 

