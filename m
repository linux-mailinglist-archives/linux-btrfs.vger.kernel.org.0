Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82714338637
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 07:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhCLGvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 01:51:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhCLGud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 01:50:33 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C6jarm029581;
        Fri, 12 Mar 2021 06:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lAKU0z5lQ5sLizoVidZrpo9I41g4/P6CziCuxlbLAgA=;
 b=Uy/Snp/zhzQblOSEzyoPXXVE0ZZkQEKTVC0Rj2Nfg/B+1xmqBwP3Zu7bTWcnqBa+nCVM
 xZk2wMO8SGRwqQw00PSAh0n4V/YfKdfflf0amGOOI8kkNiAuKXb0RcWNeiuxNYYUY0Bx
 55F4HWkS3Sr1QctxktGGHZBYC+45CRXTuVbMOGgP8G4W7MJB0YAFSnNwq6Asg2MDkrQ0
 oMtB3kWZ/T/AY5WBNIr+KOjdJYmep8nRYmGQKeVklVmH0WoZckwPLNCFBjvbQ++1nZAj
 nH+/EFWjW3MXpQiw3MdYlTVCGUo7VeK9JQ+F4XJUGgQC6/tLnXZAwQtGVLLsSE/0e23z Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3741pms0d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 06:50:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12C6jXP3104746;
        Fri, 12 Mar 2021 06:50:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 374kasvp5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 06:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtbLRM+V+lA0jf+lhZLFHBMkD58pyTnFFR9qQAVoVxY63t0ghYqV67WJ9AjrWyks7qakHck6wyzxL6/0jfpb6HYuayjoXKuwO+8GbK0aSB8JZ4UZLAWVgwFTjMpjJiE8+A8o0oaIX+pcMF8hdmTtDBIbLMJKkPHSRG6tJccFxczTG0y9YesIsEWJjHgIjfK7xqhDyP8HhoRft30/F0Zn5jjL+zEBv3WGVvjZfKvh4h/qq/K+OKeg1XXOx02De8sqdng3JGEdl+uCKLsOmph0MN+y0nr0f+GpS2UNdfC0uJ5mVgCs8svqi/bSzyr1+FokMC4Lons27tk5IzClJSDBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAKU0z5lQ5sLizoVidZrpo9I41g4/P6CziCuxlbLAgA=;
 b=KLj6q5blEy4KA2lp0RInIv8C7t2IbUm5LTZprySmAWpC4B1XMsDWiSl2yH6He4alHWqws8e2JhQO2HKAtoDVkr0psLRU1DU5CNHisVmYk1qnCJLiV2AKLge7y6GJzkwwefDu5HpUCyFUI1xmhdsxlc9dLnYyvn77JMaVmtxhvfLrb33vEQzMlQCxmil4CKQlvgjJx/xkd7/9GvTkSISTPaCpuHbJQbeFvcoEqLBeTmiy9LJIcVDCB+LpqB4Cc3CtLy0Jx4Esde6BKPJOVChmWOo1IAduhptgU7bABo5ZVhIrCIcoRugNUV3JbyIINEwojPSe99cJxHssBS6/GFPoiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAKU0z5lQ5sLizoVidZrpo9I41g4/P6CziCuxlbLAgA=;
 b=uSy5opJwU0Zf7uBqDqiBZvBKR2COaUq3QEHvX6n+UT7pF/W/hquivy9KoecHuhqGaLEQXUIVJs3++1oHB9BO7bp5OrRVOe/L3jk5f9VcxWEaHdcVayrwf2XZixYOHKsrMYSHj+0YHORxIbpMXSj+sOXH2rtU7onwmTuDhKXTBCQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2994.namprd10.prod.outlook.com (2603:10b6:208:72::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Fri, 12 Mar
 2021 06:50:24 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 06:50:24 +0000
Subject: Re: [PATCH 3/3] btrfs: don't init dev replace for bad dev root
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Neal Gompa <ngompa13@gmail.com>
References: <cover.1615479658.git.josef@toxicpanda.com>
 <b6183586bd5d9dd6f26ff4aaf3bab0a6629c6018.1615479658.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <abefa34f-8f15-055b-ab38-8b2cf3952472@oracle.com>
Date:   Fri, 12 Mar 2021 14:50:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <b6183586bd5d9dd6f26ff4aaf3bab0a6629c6018.1615479658.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR01CA0086.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::12) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR01CA0086.apcprd01.prod.exchangelabs.com (2603:1096:3:15::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 06:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e13ac4-8a6b-43fd-0b37-08d8e5231cc5
X-MS-TrafficTypeDiagnostic: BL0PR10MB2994:
X-Microsoft-Antispam-PRVS: <BL0PR10MB29949BF2493D123D0138F0F4E56F9@BL0PR10MB2994.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCy/yMcKhuMXtkVHkYYOeJxc5SuwG619JRliMI+jp1NS5Rzb0QdwvRVunxOKzlDJOStPxN7mncTgSWUDzgyKDXRnZhMvSmxVrtm9f2ZK8nM5rn5Aqvuczup5CvJEeTC8AoH7rpuF6LVc+3bQwHBqPNcpvBYVATtKBSRoMTBrea80CWe/t4zp15FDdyCM+RcQd50Obk3cC7hVwsjpIn6uwPE32QryAgy24pSO2lv835/drv5ooy50ngrCPR+IyXIX4cVWBGMGK/DaAvyN3qGDzaqWhKK31uVx43jkc5WqeKz1ELK3QtNSut+pjXAPObO7EV5IW5PTjkiq6fFUavltiQKvkcko6XkZegSTsT2KieYGhlSrzlaH6xhryIiyWFrLMN8eCQEDCYCzb8RsedPa7/dy/cF24FujDTGbesOB+GN0h5oCVxbqVMyYC08MjgRAe0nMEDRHepaEkhOS+BZmwUpepcxqKZ4r/z1wFczSI9P/W4+avj8ju5x+5nJIFtMflVSpxDiVHN9KWGG/3LJui3KaUVO4R8CidKxseucxt3Tj/zogDP5t1yh1fWQeX5faelFSaEP1KVP8NEczcw5OtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(39860400002)(376002)(8936002)(186003)(31696002)(16526019)(316002)(2906002)(66946007)(31686004)(8676002)(956004)(66476007)(4326008)(16576012)(6666004)(36756003)(86362001)(44832011)(5660300002)(26005)(6486002)(478600001)(53546011)(66556008)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pIBbpkdtZoiVdjFdypfu4/YtyoTLdxsKX0RJDmywQgLnQMVWccTAiW67ajtCjME0cX6C+PNi7GUDjTi5VvEpEdElokcc1DnYEkUl5/wh5gmxcqW2qYcxSeD9tvUBn+/+EreB4VUHbXU9u72P0iEjBC2OkkG+WJAiOTboK2/oS8yulzDGNBnzz5Vy6U2gg6ECp4prfpU/w3vXaP2wzzAKbPjmkRuZdkObNf85S7/wAXy2te/r15Eq7uiKDyGeSKMXfI6QkIdAo5/hbL9W9+GhWxRsva8Hd3r66z9kixoYxUrL5Yaz/8FJV9VfwAPF743EygNpYRQ2o7RNjEtaSwkKm34T0CycqkyJq7IX0FJW7+/3H1j++ScRJdsd3ad+wXrIBTLn+NSs/VqbLmpB6oOZ853Y9qYTwoHsVUkddQY7EuoSbEa4qsFbqzUaF/5ZpayZcGjZm2H1P5Vh6oVc3lqsmv9GmrwBhvPy01dpwnImitSZ1wfGvu5F0yh8OxPkfpcbTzBn9oD7395wQLKReZNNLFphhK8VIu6IiauOrN9SoQu6lFKG4/83ORVEI7wxrKpWD/Vg+rYK2ugV+r3fuYSt+MOs26Yb+6Ze+La2FymNWnbVq9GOF2scmbh54e1mYpQiZ4q0YejqgeRlhFTsnGM0/vDOItZ0SOAfjgXXs5FYVjwBykcq0hs31dTDuRot1TOQyXkQISLWngyNYN1KWzYVCj68IqSyfRSm1AL1+8ZQjK5xR8eZ1pxHnxy9WvbQJ6PD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e13ac4-8a6b-43fd-0b37-08d8e5231cc5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 06:50:24.5467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnQV2YoAsnCbDY9HHuao2joihcRzvte4osowBhmA3ubkoL7ciugvQ6LwARo0SUcJXZpldB7jUcC3byifoyZBuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2994
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/3/21 12:23 am, Josef Bacik wrote:
> While helping Neal fix his broken file system I added a debug patch to
> catch if we were calling btrfs_search_slot with a NULL root, and this
> stack trace popped
> 
> we tried to search with a NULL root
> CPU: 0 PID: 1760 Comm: mount Not tainted 5.11.0-155.nealbtrfstest.1.fc34.x86_64 #1
> Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/22/2020
> Call Trace:
>   dump_stack+0x6b/0x83
>   btrfs_search_slot.cold+0x11/0x1b
>   ? btrfs_init_dev_replace+0x36/0x450
>   btrfs_init_dev_replace+0x71/0x450
>   open_ctree+0x1054/0x1610
>   btrfs_mount_root.cold+0x13/0xfa
>   legacy_get_tree+0x27/0x40
>   vfs_get_tree+0x25/0xb0
>   vfs_kern_mount.part.0+0x71/0xb0
>   btrfs_mount+0x131/0x3d0
>   ? legacy_get_tree+0x27/0x40
>   ? btrfs_show_options+0x640/0x640
>   legacy_get_tree+0x27/0x40
>   vfs_get_tree+0x25/0xb0
>   path_mount+0x441/0xa80
>   __x64_sys_mount+0xf4/0x130
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f644730352e
> 
> Fix this by not starting the device replace stuff if we do not have a
> NULL dev root.
> 
> Reported-by: Neal Gompa <ngompa13@gmail.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/dev-replace.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 3a9c1e046ebe..d05f73530af7 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -81,6 +81,9 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>   	struct btrfs_dev_replace_item *ptr;
>   	u64 src_devid;
>   
> +	if (!dev_root)
> +		return 0;
> +

  If we have a replace device target. fs_info->dev_replace->is_valid is
  0, and btrfs_dev_replace_is_ongoing() is false. And num_device count
  at various places does not include replace target device. And also
  this happens only in RO mount.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>


>   	path = btrfs_alloc_path();
>   	if (!path) {
>   		ret = -ENOMEM;
> 

