Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D133F2A83
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhHTLEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:04:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25656 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239824AbhHTLES (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KApG8u026668;
        Fri, 20 Aug 2021 11:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GI3twepCgpeEbdkeS4ELiN4klLWNRu/UuRFwFG1whEs=;
 b=sklutLY2Pb/YkTm2BiEiQR7AA3LDjTC+vbHW1Xiy868AerfdzfQVY7y4bba2+ae3hDFS
 R2xkKV/OBLcyq2dpF0hYQdg2q1Q7jNC+8FfJuCAbE/0lRrd4fEX7Ag/LkAUrP2/KShf2
 N/wcwHNCBvAcBYMGtNkbF25dFhdryhgu0AIH1R5YcSdF9T0073yrbQaTyAItN6sC9xu3
 YGs/MstGQzJhGy+2VBkMONamyYTymIsGBB1N1ttqpBLRwTWdM16JPsHaB9hOXHSujgR+
 bZOp9wtxKblt+ICA2cC12wJ2+hZXWuQqAJqqgSXUQHVMEhq7PMrEYic2MqgWIqqtuYlI nQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=GI3twepCgpeEbdkeS4ELiN4klLWNRu/UuRFwFG1whEs=;
 b=NDOG2n9qoHf5L+MIldJYOZ+WJb0IgVB9QzGV2sCgIB39/C7x8Cd9mIkQyTwMyn1qtf5b
 2Yt335STywE2GzziIoR931qo68Okl8zzJf0xE0VyHI3WLpBIR0gIXocHA5DWxHe8CDDw
 XyzEdGLO7j0U7f06UdXETd3uhTnq9/Bu2VHz2Zk3S3s0eCdESg0a6R4jDk2R8DDTG7CX
 3ORZiyAYgVm0dQCA0bEpjXgGvQw03SbihKxrjszeFAxTWEDSx7+y9D5OIddUm0uCddla
 ejH9u8rRE3au4BCeA+iK2xyYeKSsdkVHFeRHnm/Sav0j6OojsVCb7NhOzoHFVf7Gd4W4 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs5cj9ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:03:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KAtBIY117170;
        Fri, 20 Aug 2021 11:03:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by userp3020.oracle.com with ESMTP id 3aeqm1gn0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffbVr9DOJU6CighJamBZ24QhsGCHvE3RMN0K6VvvmdrO76eJNBtTvVnVgDKVL7d0yjHUMQ/VMObZEiVDac+i7QkpK5rx8+G0Jzu3NZCfBVlMF2zpUQsRJVpKMgwcjdn9xlELjorylRWbcP0fxk+eNKumWpsnZxcZjD7YEbFhB/OBc7ZyY8P9/ndrGBpPiF8AdMMx2kRXRrlFaKvzDGFkvKt2g8Da4dT4nin7i5/WhwqrHhqtsYFYtnClwsA1myXkBX2p9bqfiMfzd+H/7nvms0j22bPt7FdqMZSQuO+fb4SAH1NBfAEGMSf/wNju5WaafVnmUjXOiFd/QkgT1ewsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI3twepCgpeEbdkeS4ELiN4klLWNRu/UuRFwFG1whEs=;
 b=i44p3cYFS/FNhE6mVDhATw5H8FyhpsOdjomiAnbo2kf5mxj1he1KFIjhW20q3B62h6fymVCWe8EpPIQvNXQLOr8jvT9C/HsYbJFHeJgIlXT57NQQg8XJB6BuzFEc4gydM5j4HTJln2NRNJLadyYWUMZLjNz8clcnssGGxLScLlVH17KicRVXtoUrCvNI7KGYesRrV9YuuHu+u1rx+JJqh47igLelj9Kf9geOPfYm1Hk9bDZPqbbtSbqHH+a/bslhAfQokT91c57U8gaOE7eGVN2Evg8ep+XGMoV/xoAcXqiINB4Bi7W+3DwINBadmmjTr8eJFOzuj7sXIzTz2gN+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI3twepCgpeEbdkeS4ELiN4klLWNRu/UuRFwFG1whEs=;
 b=V5k0MfTamNlzY5iAKR4LU4oNUQ6jSdecipnPSPVKDcGn2g404SBrELNbfdK2wm61XIw9YQxnWrocc9h2zqlyBZggFgRz/lcBH5z/a54sDVVECTaD36YnU5p/biO+A3iLWsF/En3l21SPELaOYFFLiJTS18J0Ri+h1zDyqno43LY=
Authentication-Results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2913.namprd10.prod.outlook.com (2603:10b6:208:31::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 11:03:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:03:29 +0000
Subject: Re: [PATCH RFC 3/3] btrfs: use latest_bdev in btrfs_show_devname
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        l@damenly.su
References: <cover.1629396187.git.anand.jain@oracle.com>
 <9a06b04b9003f86c3300e497b35b0ef0310c84c0.1629396187.git.anand.jain@oracle.com>
 <20210820105755.GM5047@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c5827d68-8634-b197-8dcd-d92e48833a4a@oracle.com>
Date:   Fri, 20 Aug 2021 19:03:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210820105755.GM5047@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0139.apcprd06.prod.outlook.com
 (2603:1096:1:1f::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0139.apcprd06.prod.outlook.com (2603:1096:1:1f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:03:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dbb9962-cb6d-47c0-901d-08d963ca2431
X-MS-TrafficTypeDiagnostic: BL0PR10MB2913:
X-Microsoft-Antispam-PRVS: <BL0PR10MB29130BF4BACD6E18190DDBEBE5C19@BL0PR10MB2913.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQFY6EbS+F5wRRtL4XBiLlQe2hX1lX5qL0AT1h6SSa7DpsDXs3mW80wGTfoOoWKpau4iNWrdRaLrqPB4lbJI6Z7SMUnmz0kjXqRmxj64t8vNgfBryil9FaxtLeFZot2HgHr7bZhPK6S3QvS8zXg6uxa+4kK54Z7OLP5QRBHdrhBz/qMtQntW89J4QGVyXCQbB8H8JTuH9+uS6J0GmNmhVF8UgcCQruf6avgAEnUzJk6UFE4Ya8nKZklYUIAkl7f0sESqhji2TNZmryuHwq4iz/3FjpVoHYEGSvNMMo8FjCC1PiSNTGpTDXH+bB2VTz22XNqfPufLvHa65XGRKWs/teegQUr8poDZetKFL9eqAL8wWI3m+TTfmo2PhFqfnL3fFVIsBt2mv9FHOFyIcnAvbQzQ7u8uzcRXmeVNQbcEboQhifTT+z1EA57s8Y+aJkXD1Ox2pAgFTF0DoKnGhp2mdcakOzffa2z+VwOSD2yBCngaAO0+BKHORnClmp7qpEYxcOqHmyrQrhDI2TEq6aroLBtOfjQxknaZbBcWWqP8ElsaRSqwTkomq/3wl9a7G9mN1VqNUDz5PdC/iVM3iempYcaLNns2ieP2cgAdyCiWAn/Tc9ivwEd99LhPQ2gg1a2TuAvsNeSyT94iXryQSskCwSrVYDL+E6r03is/xGmL19mUPYAePmUxMe/jpA6ROFSJ//bZ+O+8oGWX547nVo07d49vtZh2URLjXsJB8X6SqxgWOOYaWhP2rrWhTAbGcn3t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(39860400002)(376002)(5660300002)(83380400001)(316002)(6486002)(66476007)(16576012)(31696002)(26005)(44832011)(8676002)(478600001)(31686004)(86362001)(2616005)(956004)(6666004)(8936002)(2906002)(66556008)(38100700002)(186003)(53546011)(66946007)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm12V0lxWGhLVVV1c2pBTXVVY3p2eGVQaVp1TVAzYUx2Q0gwazcrL3JxWUN6?=
 =?utf-8?B?anpFajNoRTVQMGRidjhzdko4d3BzT3dKTW5ENmZpam83RWx0cGh6NXIyQ0F6?=
 =?utf-8?B?cXo4cDRaZElGWGU0S3F0L3FMUFlTU29iczhkR2U1TUhYTzA3R1Nvb1U5bTNL?=
 =?utf-8?B?ZVJ1alV1OFAyZERDb2xNMmFDcE1hNEltSnJTRlYxMlpwRFljYlBKY0g2NWtH?=
 =?utf-8?B?czF4cURVSUZpSWozb1pFTll0WFRKTTVJSGlNeVVWODZOenp2RWhQRDM4cUsw?=
 =?utf-8?B?UXE1ajU2NnBBSDVEZE1WdlE2MzloeEx0WFVva3pqSmRJdXpVM25IVXNOSTJX?=
 =?utf-8?B?WjZYTWkxSzR6Mnh5ZGRJSWNud2NhcE82Z0VtM1Z2MFEyWnhBUlhrbjVRM0N3?=
 =?utf-8?B?V21MeXNCMlNuelArRGl1dEZTcVFUdjJFK1g2b2pFQUlMeG5kM0hlblBZRTk2?=
 =?utf-8?B?UlpuVlBXVmdTMThaQWhEKzlMeUVVWi9pdm1HS0dlSTFyTWJwaFpkY0pWNndk?=
 =?utf-8?B?QmVQTHFHaXFCZHMxRm02K3h1VHR6VXlNTXVydHp4aXh2N2xwcjhWUHJJYU8y?=
 =?utf-8?B?SG9QYWgwMHJ2YlVOd0NRNG44YWFjVzVta3hlOVFDMnd5TU1QTzdCdWhHV0ts?=
 =?utf-8?B?anBxN1VrbjZyay95bS9vTlhnU2RFQkxYbmN0emc4cnZTSjVoc3R1YzdFQWZj?=
 =?utf-8?B?VXNBMVJMOXpYVHgrQUpQQUlBOUZzckJYdXM0RWNzTDR4K095WEpFSXFySWJH?=
 =?utf-8?B?RjEzT2VkdGpQaHVQQlNZdWpJVEg3VXhpTjlGaUlFbExtVTVmdkorcUNpeHNS?=
 =?utf-8?B?LzZVS1NRZDFIcDAwb2FFdGcrMDdyTnRxN0xNT2NqRzNiaW1EV0VkTENUSEJa?=
 =?utf-8?B?NTBCcDUxWGFnL2pVWjJzSHhLNnlkYjhtL3liRmZkTTlQTFltV0lsVllDMEJ0?=
 =?utf-8?B?eXZRaUhGOS84cUw3NklXWGRyZmUwZHhxZTdSQmIveEt6ZTREdDcxU1hRQjJS?=
 =?utf-8?B?aCtubEIwdkRodkZEU2oyNjM5ekw3U0NhUWFoc3NWRmZ5UVZVZGhVQ1V0ZThH?=
 =?utf-8?B?bUlKNWtYTlB0UjJPZmVYRkRjUDhmM2F5aVZRK2thYUJ1MCtZVkhJdWRuK01Y?=
 =?utf-8?B?aUhqTDJqbFA1cXBmOFBFdGRIRFcxV2w0MktPK2dzRFJValh4RTM0dmg1L0Ji?=
 =?utf-8?B?WktacHFvdFZKVGphdWs1eTduY3BuQ05ndzhVNVA5YkhETGZBZFJIUStOcVFi?=
 =?utf-8?B?R1Y0bDJkNmQ1RTFlMldrajVPZFB4V0ZEaG8yT1V1OGl4bFlLc0xjTnJPUVJV?=
 =?utf-8?B?VUYrY3BQc2YvYmJ3WjNQd2xXd2l6alNXU3g4TkpDNUFxeFZ0d1ZMRTNzeFJs?=
 =?utf-8?B?WkNuMzdMbENtdzZ0QTdheGdPR0lPNFpXaE81OXJidFJ0N3hjN0RoTXJxVzhQ?=
 =?utf-8?B?aGtwclF4alJ3RkYwMzR5UTl5eG1WMnIrais1WWNtWHVuOVFqejNobzR5Nkc1?=
 =?utf-8?B?RUp6UzE0cFJnZlQwekgzOHJUS0NVU1I1TW91ZFZoRmJqM3ZZaS9BOWlRdkNE?=
 =?utf-8?B?aXZMZWZFdWVtZTlQcXVRQ3RYTWUwOHJlazIzUUsvdHRoT1FCNGpNRDlIT0Rm?=
 =?utf-8?B?NUU1WGhWMG9wSWpNbGFNa0E2WHdLUEkyREFFRHM0OC9YYXg5SjZjRWZCZUxa?=
 =?utf-8?B?Q0ZpMjJORjhpTmFtZDRpWk02bUd3UGE4eW9BN0FvaWNoK2dLdWttR3c3ZytW?=
 =?utf-8?Q?w8fBJIlS7zEUI43mwW6AZaQvJM1GiYI8R5INBq4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbb9962-cb6d-47c0-901d-08d963ca2431
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:03:29.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8fUI44VVUU6w1qFoQ2eJBS++U+0bPImz9wPYQalrMVX995FCIBYr3lHep26jc7kPeFKtzJipMrAo5tV0Dxc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2913
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200060
X-Proofpoint-ORIG-GUID: wxrFYHbUBBjsZ8X7-e8LOMdKiR2X9og4
X-Proofpoint-GUID: wxrFYHbUBBjsZ8X7-e8LOMdKiR2X9og4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/08/2021 18:57, David Sterba wrote:
> On Fri, Aug 20, 2021 at 02:18:14AM +0800, Anand Jain wrote:
>> latest_bdev is updated according to the changes to the device list.
>> That means we could use the latest_bdev to show the device name in
>> /proc/self/mounts. So this patch makes that change.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>> RFC because
>> 1. latest_bdev might not be the lowest devid but, we showed
>> the lowest devid in /proc/self/mount.
>> 2. The device's path is not shown now but, previously we did.
>> So does these break ABI? Maybe yes for 2 howabout for 1 above?
> 
> The path needs to be preserved, that would break a lot of things..

  v2 fixed it.

> 
>>   fs/btrfs/super.c | 25 +++----------------------
>>   1 file changed, 3 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 1f9dd1a4faa3..4ad3fe174c41 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2464,30 +2464,11 @@ static int btrfs_unfreeze(struct super_block *sb)
>>   static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>>   {
>>   	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
>> -	struct btrfs_device *dev, *first_dev = NULL;
>> +	char name[BDEVNAME_SIZE];
>>   
>> -	/*
>> -	 * Lightweight locking of the devices. We should not need
>> -	 * device_list_mutex here as we only read the device data and the list
>> -	 * is protected by RCU.  Even if a device is deleted during the list
>> -	 * traversals, we'll get valid data, the freeing callback will wait at
>> -	 * least until the rcu_read_unlock.
>> -	 */
>> -	rcu_read_lock();
>> -	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
>> -		if (test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state))
>> -			continue;
>> -		if (!dev->name)
>> -			continue;
>> -		if (!first_dev || dev->devid < first_dev->devid)
>> -			first_dev = dev;
>> -	}
>> +	seq_escape(m, bdevname(fs_info->fs_devices->latest_bdev, name),
>> +		   " \t\n\\");
> 
> No protection at all? So what if latest_bdev or latest_dev gets updated
> in parallel with devicre remove and there's a window where the pointer
> is invalid but still is accessed. The whole point of RCU section here is
> to prevent that.
> 

  YEsh. I noticed it. I am just on it. Will fix in v3.
>>   
>> -	if (first_dev)
>> -		seq_escape(m, rcu_str_deref(first_dev->name), " \t\n\\");
>> -	else
>> -		WARN_ON(1);
>> -	rcu_read_unlock();
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.31.1
