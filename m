Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B5C2C42BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Nov 2020 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgKYPRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Nov 2020 10:17:00 -0500
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:53273
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbgKYPQ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Nov 2020 10:16:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/UeYbWlsUujXVEtp+e+hvnWbhtjmxi9WO7mFxUjMJ2JJ+Gvxr21M1zGEoPb+LPHI0AfJFdEFedWwntRdXqSh24JRTuVGOtlz2O4w1ZyrXZB3QSyaVSzz6zBQC3Mod9rUZ3gcqaCxEEUvjcdK2lq8jdkoms6bvR0tSGJoC064HaM4CGy/KcVD+5TjBBfBBdpgF+gVIgJZRd3UKeesVFvpdJH9SaqciKPwOue4WWWD1TI5hZqNYzB4LsWjyqH+BULZdZHyrrE/PZJLNdL+69LYTV8EyX414BDkxGkz58uy8oZeZKsd+R/HCiB3+stbuqpmUDajlBMW+MTEjOYnZdXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjjvTgjcFB4YDyPypmXulCl5HnzYc+zDN8MpLVjfLj0=;
 b=RLnBT+HzQcftiK2hhfciWncGe4ttvFvlTeuUcNL+T1R3Yzd0OAhLPNs6QrjvbBrk+qUw0xqD1CpnKxGkRjWOoGn4WId+YzWKrMvk09YllYVdm3MNgEVE9PvdR5wyV2l/cJ0iXSBuQb95uqaVa1r66mNPhLF2Woh+QGRhdKdwEA5rOE1/ZKKEn3l5wNRZWRUPacuyxIuze5B0Tgi4S4THmXSl5SROEsu0rsmArsleKOXYt3Ed+S9jQBNfDKOW7W9EuFO4E4NwIIyssaVmkDBP+z1kD2od2QIMMgKpj3/hTyhV44LOdIkgZ6G+hUT1MUYAF6C0ZEExOV35uu/YkUe7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjjvTgjcFB4YDyPypmXulCl5HnzYc+zDN8MpLVjfLj0=;
 b=kr9F3q/ID7iL4gBEkADok0UHECjKzCi6Mljz3mDQIpGSFUICnuRQp6mmodvGECqQYYBOu3SYumUs6ynFFM08BXaPYjVvI+gqgd9Zwpjwqw+hxtasKOgJbZIkkqD9tT+1e3kLHlHS+GTdeilHoADOOoPvKq36when8LXMyyrztwc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by SJ0PR08MB6717.namprd08.prod.outlook.com (2603:10b6:a03:2ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Wed, 25 Nov
 2020 15:16:54 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::f8b4:660c:838c:7040%7]) with mapi id 15.20.3611.022; Wed, 25 Nov 2020
 15:16:54 +0000
Subject: Re: Snapshots, Dirty Data, and Power Failure
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b58c6024-1692-7e43-c0a5-182b1fae1cca@panasas.com>
 <20201125042449.GE31381@hungrycats.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Message-ID: <60820e39-5277-7d16-f3c2-bca7c3b44990@panasas.com>
Date:   Wed, 25 Nov 2020 10:16:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20201125042449.GE31381@hungrycats.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [96.236.219.216]
X-ClientProxiedBy: MN2PR15CA0016.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::29) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.2] (96.236.219.216) by MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 15:16:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 885cfe89-da96-43ae-61eb-08d89155249e
X-MS-TrafficTypeDiagnostic: SJ0PR08MB6717:
X-Microsoft-Antispam-PRVS: <SJ0PR08MB67179069E2BF9B11D608808BC2FA0@SJ0PR08MB6717.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYErXzy3xDgR36Kz0E7Mow0TL4L9+/wlln5y1q2iyR0GTcZaZZFI2CJ1J+IIedR0Zl6etBqaz4ovYeZ115XqP7iUpiz7qxAtgKrckKWTbE/s3AqvD1IcV/NYOvdTGS8PWoQE5FuyrurfIRheGiKAl2Tb/YyHOCFbiz7eHNbL462WfM9iXB6SKLQI1Ck5R89AmCLP/Jn1ljuuiChNLsQ3wYD9Lqlsty3RZ6XMiH6vuOvbvWekVFI8Y6977vY8AsGk8naFvy8uPRI7ckeJrMsUZk95MAQaR2/RAGwzP6ruPQQWOKmnP+BmmH3AtWXjq9nH9tn09G0dYeS4fF5Kv973pqBmc6E5FGCSZDXdeCRi5HDQLaCOvl40rItXIUwzQUUxxjbIcVm7gl1K87USmdCxkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(396003)(136003)(346002)(366004)(376002)(8676002)(2906002)(478600001)(16576012)(8936002)(5660300002)(66556008)(86362001)(66946007)(316002)(36756003)(66476007)(31696002)(2616005)(956004)(31686004)(6486002)(4326008)(26005)(186003)(53546011)(83380400001)(16526019)(6916009)(6666004)(52116002)(14143004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /+UsBngtzUiaiCfvKqUEIzJuLF0oT1Mfyjrfq4tCv1mLsq1pR9xYp2TYcv8yYE+WIHwOtg1c/Q41lRV1vbDRk2ehxu1yuCfNtvajJo7gU8hPDDl0ukKV7wWJo9j42/4AUUWQQkY0FmbQGTkCJwlpYO76a7fAN0skkdONDAlBksobWG+k86WUcWYOe6QaRjb93rXJ8KToPVFyND81VkH0ODZYMp9FzehRAcX8u+57SDZlWr+5h6p3t8zMQi3DScuH4Nxhh6h3v33ugU01JFcgQc4Bnk6WD6YGUtRKhVFBDuhJEXU8Hk9sMONviJGrpjJPpAnR2WpvrcRFGX1vv3c16Va75b1x9L/pdxSS6hQHa1lYYmVjdovT1gynZsI4LrEAYgb+Z8ZaRZku7Mi7y+JmmfR4zHTMvge4KLVETuti8qNAal+yqu4mVUux1zMHnoYAzZs4ONWyUcPWimuDT+PxZq81Dtd+ZV+RkN8Tp1ll6bklPdc9vR0+Mipb8S5hHzgSTnm+po+pzb1dbIRE0PkiU+kR9OOxMV5/tGeg7OjMt41A2cZF0O/ZuRR+3Ho+nTB1rgS0W+EL4fPt6ISy8a2mLEw7rRwnuWaN7NJyNkcL/OhVn2n10nLf6Pf9ZaxBEay15AGM9I0uxPWrls9kKL8WDMZNfT5x7IhCiV986SIxdO+uYw9SDO7L40Sfovf1jYxzXYxxnnlEBSndd4LGI0Spd+TORm9yJG7tHRyHp2iCt6nVIQrimUv0WDseL+4X9cDNZuK/IwJVbLyaUOanAdwuzJm8EpGQ2lX8I18XC3o8WYke7sbxTmM5xkqC/rKsv2RClspC33wRsZrwygZMkV5DOasBH3YyImGGMtv1AvKRAHx/CEYfYtmYxAiHg6fK2vn9nK9kiKNVCsoN03XDLO6zWA==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885cfe89-da96-43ae-61eb-08d89155249e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 15:16:54.6761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pnp9NFCyQQ8dNyYqMTQMkFtJppqs2ERhX7i80YoTu+tabZGLvn1RGjE+AEu74XA+AL0T908JateLk6cFzKNyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB6717
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/24/20 11:24 PM, Zygo Blaxell wrote:
> On Tue, Nov 24, 2020 at 11:03:15AM -0500, Ellis H. Wilson III wrote:
>> Hi all,
>>
>> Back with more esoteric questions.  We find that snapshots on an idle BTRFS
>> subvolume are extremely fast, but if there is plenty of data in-flight
>> (i.e., in the buffer cache and not yet sync'd down) it can take dozens of
>> seconds to a minute or so for the snapshot to return successfully.
>>
>> I presume this delay is for the data that was accepted but not yet sync'd to
>> disk to get flushed out prior to taking the snapshot. However, I don't have
>> details to answer the following questions aside from spending a long time in
>> the code:
>>
>> 1. Is my presumption just incorrect and there is some other time-consuming
>> mechanics taking place during a snapshot that would cause these longer times
>> for it to return successfully?
> 
> As far as I can tell, the upper limit of snapshot creation time is bounded
> only the size of the filesystem divided by the average write speed, i.e.
> it's possible to keep 'btrfs sub snapshot' running for as long as it takes
> to fill the disk.

Ahhh.  That is extremely enlightening, and exactly what we're seeing.  I 
presumed there was some form of quiescence when a snapshot was taken 
such that writes that were inbound would block until it was complete, 
but I couldn't reason about why it was taking SO long to get everything 
flushed out.  This exactly explains it as we only block out incoming 
writes to the subvolume being snapshotted -- not other volumes.

>> 4. Is there any way to efficiently take a snapshot of a bunch of subvolumes
>> at once?  If the answer to #2 is that all dirty data is sync'd for all
>> subvolumes for a snapshot of any subvolume, we're liable to have
>> significantly less to do on the consecutive subvolumes that are getting
>> snapshotted right afterwards, but I believe these still imply a BTRFS root
>> commit, and as such can be expensive in terms of disk I/O (at least linear
>> with the number of 'simultaneous' snapshots).
> 
> If the snapshots are being created in the same directory, then each one
> will try to hold a VFS-level directory lock to create the new directory
> entry, so they can only execute sequentially.
> 
> If the snapshots are being created in different directories, then it
> should be possible to run the snapshot creates in parallel.  They will
> likely all end at close to the same time, though, as they're all trying
> to complete a filesystem-wide flush, and none of them can proceed until
> that is done.  An aggressive writer process could still add arbitrary
> delays.

Very helpful and yes the snapshots in this case are being done to 
different subvolumes.  I think if we can solve the writer problem (I 
have some ideas) on our side then we should be good to go.

Thank you very much for your time Zygo!

ellis
