Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31333F2ABB
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbhHTLHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:07:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57138 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240502AbhHTLGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:06:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KApTaD010530
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 11:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T09xoeQsGBabqXilbF37eXEKsBpTSbVQh/R4C0f1WVg=;
 b=vmz+Ro6WfdHFz65j6gax3TmM2DpKCFT3q0Xnc+y7+6Azhhi7jvpTxeewMjxFgIyKuZhF
 xkdC7Tnh5RCUh3kSMdKbzo3g4Ex9r5CCF3wtsRlBTne+rXnVefbewhR5+dHRhpmISc2p
 VOh8AUAXJtejvh9W3vD54smIMqYgnJJCztsLbvUfrcVBR8dSeftXgxDn8zAyPJ5vFoQM
 Ni+2Bz5cLwxTTG+LnZYVyBkz6+cY9r4puKL7P+joCXsRAGvCx0D6E2xj814tYwAPilgY
 VAxxOcfdRi9n1cNNRMzsbpU/Zn+JP8fEsnNImVaeT1WkukJxVqxEoM63cOlEuRHFro5X Jw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=T09xoeQsGBabqXilbF37eXEKsBpTSbVQh/R4C0f1WVg=;
 b=fxH4tvlgX2ep5jbVoIlEpcPoB0zY18NkKhWYbOCEmXXcmlRSeJ+pzVCrJdcfQlN2aDZo
 y4YpWnS+zwq6nfxrkB/0Xf3GMM2kthLQwVi6WfDpiVRB21CYnD3CAr3dm//K9RWOIWM+
 OmDWKdTitJAvPi4s39jAVb/C5FpuMs4Nd5Z6zvTNB/8XObu6YGv0R7wOA6Ne1RLGfdiv
 0VCJnpcrt17ha1CVB9hCsR+HJsz+7pcdOxQeM8lfhMEaM1bN8PvN0hzF70PIoNHjBt6W
 9/hbck7I7eNQJSMAkDOPPyU5XGLKBvVAXQGbG0ji97P0gUV9cUVywjbXodlO6hrnzeLX 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aj6rfrnmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 11:06:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KAt48v136010
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 11:06:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3030.oracle.com with ESMTP id 3ae3vnbphn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 11:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmAEUlYBrOtKuEA9JLaSBAiLJE3Tyypq1AlRgRVQxTezz4KsQSMeBedPMNF39bIMqHiBdWzvvRTZplIaQV0qq+l+WWYcho1+BoJD6BPCihzpiDURlBHhiEfRqeqSTjG9FKzph6ipu54SSIRTBi4XBZ49xN8dMOyZfdrr068BseXO4tOhCfDoJl1RG9mph7o8tQdthMHXCUZw22Bl9ysQ7Lq/JPzl8RU7NBSG60uS6VhgC8qUbhjd0kEvn1y8oQs74PbVm3wbTka0ysaImwSzRBXZkE06h/8pVrSrf5TwQQgyoZU4b58Bo5I4z6pdlHrZyIQdtJOjGR8Hctv1WEEJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T09xoeQsGBabqXilbF37eXEKsBpTSbVQh/R4C0f1WVg=;
 b=e1nSKbAJOXCdbA3wAxwSiRr0YCi6TO/edAALg/5NMIjBar7fwS9DCInMAdyBtArLThaF2OVSt2uNK8SRTU4Trrhn9h2EPdrChS46D+WKx8ZDa8OvkeNtNKKWFjGBJxhyfFTkrWhNIxTngN76TAHTNXfX+fz9hbClJaWZBLqoBRNTceUFEtsHu6CScrHpE7+9K+HyCLd5nsPG9TQtTKCUk+JCYi+LAuytFFHX+aVihFO6JbTegzOakihQFamCX2iYjnXURR1m66kdBzKP4NQdD6wyU5thm+m6wnWEPLdAQVeqIesGbwfpiYM1I+zRsarZeXyEBFhWAfS/mKAA+Sy3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T09xoeQsGBabqXilbF37eXEKsBpTSbVQh/R4C0f1WVg=;
 b=kBEB94gjD90+mf3p6SX0NbQum7fiEAndkntjoGvRr/CAlBdA7AIZeyQ2LC5/Fms7yDALCt/lYS0BH4cUjHUqyfXwPq3fCBRzVl3hIP1GZ2ShiZ6YLTgc+NbsWVnwhSVDSnBZj+pjIuVMlucOPe54C6+ShSC4vTKyjeV3apdOYSM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4046.namprd10.prod.outlook.com (2603:10b6:208:1b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 11:06:11 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:06:11 +0000
Subject: Re: [PATCH RFC v2 3/4] btrfs: use latest_dev in btrfs_show_devname
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1629452691.git.anand.jain@oracle.com>
 <7c09f4adb27f4dc9de47ec9a4b8b4b540036534e.1629452691.git.anand.jain@oracle.com>
Message-ID: <e131b7e0-d24f-8e99-b33f-e602a1e232b8@oracle.com>
Date:   Fri, 20 Aug 2021 19:06:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7c09f4adb27f4dc9de47ec9a4b8b4b540036534e.1629452691.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR01CA0156.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:06:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875d47b9-bac2-418c-35a5-08d963ca84b2
X-MS-TrafficTypeDiagnostic: MN2PR10MB4046:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4046A3A7FCF46755E9D91824E5C19@MN2PR10MB4046.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SrlkutgsmntpD08SAJSJcxETsaGfs0iWVWKiXKxVrbYRdUPRjPOpcUT7bAHHz6G0vKMIYSgUeJ6KO5Eia6DkkCGIAqs6U9oWFcrmJqY3d6GsBTIKOTg/XhASFZBKP7xwnJvjrFT9e9qgMIlZl0UUkI1AXpwV0iubUhZhlOxyNY83Jg2lAGNoTmA8iflKQIoeLUlG1ybnJ+6eQczGh/WvIJCAX5N0nVErWaMabbwqrvA3QArPFnVgDkhFlU6+GhJIkTcweIcSuiM2Z59me9jObX8k+x6K/ISzXmP2wEvvufMazXFsrEkqxuKQwyf9IZ1HlCGeL3U1Q1HbYPAGNa4d1r8M7BSixiQC+Kwuwc6yMBcbjLHo2EmXdS00szO2os4jaQpgrY5fXHNmvRaJoVGKC696z8k5Do/LujDhA7/OE/uIyFNxu+huSIQ0NP533Njzs9+V2MgrYZh2KcqeXZRT8Xf3uvsnfqIsO136W87OD2U7Unv1YA/6QF2f0DvtoaNhZqHoC/xC4BH0hijiqYSsTCwHGvjoW8MHRvEWF+pwEQm41PXUJfDO3ZyjotH48mn9uBaL+TmqZbJa/VhYtyA0JzM9hq1lHcW6MKXRaEA+hlwxwXZ2gqTZJsOZNebgmeNyUDnJ9RdpzHBpq61BGGQX/uy4IvxAFI99r0W+HD572oIraVEudfmiw313qCXcoIGUv3Yw/GOi46M3l+mX2Hp6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(396003)(376002)(346002)(66556008)(6916009)(31696002)(31686004)(66946007)(26005)(66476007)(478600001)(8936002)(6666004)(2906002)(86362001)(6486002)(5660300002)(8676002)(16576012)(316002)(83380400001)(44832011)(38100700002)(956004)(2616005)(36756003)(186003)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXRDKzlnMGVFSHZqUWxEZHdCNDg3MHBCb3BNRXVTK2p2WGs2ZWRWaENLZnAr?=
 =?utf-8?B?ZUQxVy9mK2tnVDAzVDZQdU02ZVZFdUhzTTRQSkZqeHJZQndMWC91R094NlI3?=
 =?utf-8?B?bFF2T1V5aEVtbjAzSzJCdWs4M2FuVGt6NmVUeWVxbmdDdGhPZGhVMkZmTjlj?=
 =?utf-8?B?ZmlrMFREY2dDQnh2UTZtdkdyZW8wL3UyL2ltYkhoZFBxRVBmT0xyZnJJaUp5?=
 =?utf-8?B?eTVaenJHenl5VzB2eWUxMk9XT3FkdHM3WFU0WDJaVlc5enJxMHhsWGRjQ3Fl?=
 =?utf-8?B?dnJLQ29aRXdkeEh6N0MySWptM0RoWU0xZkhhRVhjZUtndS9Ta0k1MmR0dXJO?=
 =?utf-8?B?QTNQb0xkVzZ5eTZHZUpiNFRWRGdEUndna1g4dDlvcGxuMG4zSVkzUG5oc1FJ?=
 =?utf-8?B?K0lHUjMwVjJGWHJ2RC9idEtXWDMyTS8xdVdPSllRWG0wcEhYd1N2NXBkRTVa?=
 =?utf-8?B?UUV4UUkwWEM2cXMxR0RHSUQvY2d6bUhXSk5pQXJ4QWp2WWdma0NONGc2NEdV?=
 =?utf-8?B?S0crbUpKcmhubGJxWExZaVRBUEh4aVBHUUw2c1M5WWIxeUVINFBSZWFpSm5a?=
 =?utf-8?B?N0NYZ2JBd3A0MnlVaWppbXhUTEpTdjZtck5ZMVhjbkNxa0FIbWpNUmVzeFNH?=
 =?utf-8?B?eHBkSEN1eXZ5R08xRkdodlFnT1JheXFLdERQSjBaWUtzUEdnTlprTXZodUt2?=
 =?utf-8?B?M3YrU0x0SER2eU1JbnhKZTdvalI5VUQ5aGI5QzJMUU9ZZnRtS2Rab0Y1UGxq?=
 =?utf-8?B?T0dSMTdaTExPNnBUTVB2dEtOK1FYYjZnd01CdGlXeFhUelJ1eGxaMHJGcVcw?=
 =?utf-8?B?dyt3bXRDVXpJU0FDZVNocldFQWRhc3gwNUQvM3J2U3JXUktvV0xsMW43MWxJ?=
 =?utf-8?B?WTFCY2hMSm1vZnU5VVpaZXBUUFR1VndpWXFDK2hNd2s3MGtVOXE3NFpuLy95?=
 =?utf-8?B?TU9obnRkMXJKdDU5S1NzbGpLVDZRampjSk9hOFZGUTdrVlo2TFV6bVJ4L2w2?=
 =?utf-8?B?b01NT3daVWQ2bks4MUNnV0ZrRGRCZkZEOXdpS3BKSlMzSzk0V0w2ZzFPelNB?=
 =?utf-8?B?N095dmNHbnBsMW5qUVV1UkVGVnYrblVydFBweGZ3Y0JwNkRpb1I3TGtTNTVz?=
 =?utf-8?B?NXVXNWprY1puOXBYL3B0cEhTWDZ1eVZCdDZ3RTFXNHRJUWxTTnhQSlg0Vk9X?=
 =?utf-8?B?Mjhyb2k1elV5dy8vdEpHdXZmeVc0b25MQy9PdUtxWHNTYWtZRUoreTljdWNu?=
 =?utf-8?B?WmhKaG9MSHN6Y1k4ZnVZQU5xUnJNLzhVRjcwQ1dESlk2UFk0bWl6akVKWWNR?=
 =?utf-8?B?YlNoaUFhQjRzK0RLWU8rdk1IL0tkUEk4ajJ5WW9heHNscEF6Q05YVGpVMXB0?=
 =?utf-8?B?UDVxTGlWU3ZPcDdUNUxsRG83RnRJYVpXVWxuc0VEY0VROEhMWG51bTB0NWdU?=
 =?utf-8?B?ZmwzVXdtVXdVWE9ML0l1QnhMQjJrUjc0S3huZXVKclhtaW5qVnp0U1BIaFZ3?=
 =?utf-8?B?VDFTVUpiMlJSQWNQaWJONlJGL0FoSlVDQitlVEtpS3E0OXorQUU2a2xQLysy?=
 =?utf-8?B?RXViR01QWjRvTXVLMmlLdlRIUEhaV3JKbXFVdXA1eUF2dWZGSjArQzdNNCtk?=
 =?utf-8?B?OUt2VTlXamYrL1J0L2kvUUhsRTVUa1VXZUhUZmRrT0xnS25JUTJOSDU2d0Qr?=
 =?utf-8?B?aytwK2dKc3B5WWZtOGM5R3hrVm5GOGRid3VtQVB1VjltaE0wYzJRNVdPZmdq?=
 =?utf-8?Q?NpN7PeIBxy95ivmOatpVV5mJI0lw35IFxtQQtDf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875d47b9-bac2-418c-35a5-08d963ca84b2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:06:11.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85Xx9q/ku/v0au3W191HyrNt91aoWvHEgNhQFWNAdAwjQFKkC+orVlIBauV8zYID8SnVRO3fPkUSxxv+bOmlgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200060
X-Proofpoint-GUID: OHmHXMtdOqQT2lWh0DZBlcCCBcPUGmaa
X-Proofpoint-ORIG-GUID: OHmHXMtdOqQT2lWh0DZBlcCCBcPUGmaa
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/08/2021 17:54, Anand Jain wrote:
> latest_dev is updated according to the changes to the device list.
> That means we could use the latest_dev->name to show the device name in
> /proc/self/mounts. So this patch makes that change.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> RFC because,
> 1. With this patch, /proc/self/mounts might not show the lowest devid
> device as we did before.  We show the device that has the greatest
> generation and, we used it to build the tree. Are we ok with this change
> and, it won't affect the ABI? IMO it should be ok.
> 
> v2 use latest_dev so that device path is also shown
> 
>   fs/btrfs/super.c | 24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 64ecbdb50c1a..6da62ebda979 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2464,30 +2464,10 @@ static int btrfs_unfreeze(struct super_block *sb)
>   static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> -	struct btrfs_device *dev, *first_dev = NULL;
>   
> -	/*
> -	 * Lightweight locking of the devices. We should not need
> -	 * device_list_mutex here as we only read the device data and the list
> -	 * is protected by RCU.  Even if a device is deleted during the list
> -	 * traversals, we'll get valid data, the freeing callback will wait at
> -	 * least until the rcu_read_unlock.
> -	 */
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
> -		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
> -			continue;
> -		if (!dev->name)
> -			continue;
> -		if (!first_dev || dev->devid < first_dev->devid)
> -			first_dev = dev;
> -	}
> +	seq_escape(m, rcu_str_deref(fs_info->fs_devices->latest_dev->name),
> +		   " \t\n\\");
>   

  I missed rcu_lock here. I am fixing it in v3. Thx.

> -	if (first_dev)
> -		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
> -	else
> -		WARN_ON(1);
> -	rcu_read_unlock();
>   	return 0;
>   }
>   
> 
