Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C0B603645
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 01:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJRXCM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 19:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRXCL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 19:02:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DECBCBB0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666134126;
        bh=O4jDiOhBf+MILLBXmc05CY3j/vVDao6ToPJEKrsZEiM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k9zelrJy59UzTLBGTpmcFHth3zIbSItZ8tCRpXkgjEMbPyDg7uAxb35k8NyeeErN5
         mtKYLnJ+L+6vjAdIjQG6xHSHP/kgBc0Gii3l7k0zWUoOzpGnaDlh5A0BfaeURm2/5q
         tW6243eyt/2PnxqFuZQ+klWGecOq9+2+0bI2Vro8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlXK-1pRNwh2o7y-00jo4S; Wed, 19
 Oct 2022 01:02:06 +0200
Message-ID: <526d3122-3e1a-cfa7-9a1e-da0fd552fa84@gmx.com>
Date:   Wed, 19 Oct 2022 07:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] btrfs: make thawn time super block check to also verify
 checksum
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <b5eb3e1c071c9bd79dab0bb9883ad86843e00051.1666058154.git.wqu@suse.com>
 <20221018132810.GV13389@twin.jikos.cz>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221018132810.GV13389@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ghWKCFvZppL/aTH6lpCG7glApZ9/vQjwHrDC0X47jBEKoyr9Fg4
 TH6hbrbQ8yCLFYPMAbxL89XNYCvhXwAUj90ECbH6bwUttQDyCxzlat0Wi7Apbkzwc5NHogp
 Pt7uMOsddZthLWv0RT6yOSzLQ/tOmePvShf4qy+TMc5Ic86JcBTN7QsGgKuiF50v8eiQ033
 UF+WG9oPb4L9bZhkLthPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Osrt/Y+bQyQ=:VXLbZuFD6kvxuEH496U2YL
 3BbgfsUkjHDnMfXNW+jXGLzdMXwzu/Df0tL5jOlVccDAIPJwzifTb0a7xMecyldtfXqscq5lD
 TWlqwVtE3ZCDBbr3RA2PNFySYJclH4pEo2wGSepRiBhWU/enNujlLX3Em1J+Z6fn+tNS3JElI
 /vX7VtQQ6soFybTJK4UXxjfAN7PNWFmA+AJeFC9Pto1voL5TrEVeWrapURCNxfU7S01JsYVMU
 ISQ+nsxMKhpDVkn6iYVaW+ReaGr8n3PgdrT9AzoBgr54T19y0wLvttdamwMuQ+VT5RBRaJkuE
 6vSY/KHfn2RkyXtP2PTamiRrZx50bXipbt9jN5bKsiGoI+V27n/MlE3vWmwzPSSbahACnQuDb
 HEWQvRl8TxTUiJ6KeaeJvvkzhkSSNAPnl9qsOzAbf5Jo3rUnjM+m+7h0B7wENl4P0SFlBLe6t
 IDPqzqWU/jWsdGJAz+YMy0ATEQhLU7ESsZFlyo7ghZQeHfb7pEHwvd/w2DJz+aLlqCgJxAudD
 c5SqOeZQJ+TUEzBx3CLcI+NNRLblk0xGSufpRQ8eKtj+bcmiAfjU4Dki+jAjTmcnrm+61pAW5
 TIV+VLq2UeydX9YDi+AQ3QumskkKqEHE6u2yRGinpydVJAWCzIYN7bmXjp0TNj/zXMWJAcGCe
 9UvbD+PIlDJv6O039/BuaW5GqVIoVVbJgFXUx6z4hNUdhRw2ocAr0bCUaDEKwy2Qff0/puM4k
 lY+47CWQKPPzZAhZUonjx0gED0g5Yjjhr2pTEDl/3aqODYS4G9+LjKKx+lozzDzToU9np6cWR
 UCgCR9csASuvNcZcPgScT3LXxUSDhmktgXEwh0Mnx23llA1GlZ5ER36N13paQiK5c12upuOVj
 gVcXNOwCPSTz2BaMuSVlzCNf63eXfgFNvKIjLEJpICKxbonflFcggoS+oLPK+7x+CVn6LIpcr
 Vo0JNWLsCQsOr+8UwXLY/NdjegXPHDXVn5gF615XVP4M0/fpuJnqfbxTK5DJQjjilf4GfUaQC
 +i2p40DbioYJZgltLOGhW7VygM43dFcMQWTAj8MW5sgy3rkv8+IFxkejdCkFGYFsXHQr8eg9D
 K/IOI9D8SHQUwqIUKbSjaBaRvltKV/ErQs8yQpwun8hSjC4uZ44xrNOwYGVuwUdD1Q4yWsDAP
 wwyUjSgxVDnSq02dwEgTQAoRArWHYCMBxQkgIqUjldi5qqhhCp7t0+Huc6v4YSTtvwjf1sHYm
 cjUtHOA0oeExLyJsUcBVp2OGJsYsmAPMcYHL2ePd0Cj9UNO3r1P//p/vtUU4nGCmcUS0H2p/Y
 Jb8b5rvd20UEd21Wy7jGhPo0F1lvYUXDK6WypwCD56Yy6srUYR864bU8DcOVSGziFs2QtyAPb
 r9PIPLTDBzGzTILX0Irbu0v9lHlZsrkWZiKtgT+QcGtigQ+7+WzdmzFdKHnwJhpcAo33AjpfL
 c1tyw6UmeNonzJLtATJL8Dk1nFLzW7OC1Np3PyvRPiHLl37D0bfJiWaf/Bhq3KtDtDcK7+lf1
 n2vQFSHQJNH/AqNodEufjVqcu7S/QWaYcIO+my4In9fIN
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/18 21:28, David Sterba wrote:
> On Tue, Oct 18, 2022 at 09:56:38AM +0800, Qu Wenruo wrote:
>> Previous commit a05d3c915314 ("btrfs: check superblock to ensure the fs
>> was not modified at thaw time") only checks the content of the super
>> block, but it doesn't really check if the on-disk super block has a
>> matching checksum.
>>
>> This patch will add the checksum verification to thawn time superblock
>> verification.
>>
>> This involves the following extra changes:
>>
>> - Export btrfs_check_super_csum()
>>    As we need to call it in super.c.
>>
>> - Change the argument list of btrfs_check_super_csum()
>>    Instead of passing a char *, directly pass struct btrfs_super_block =
*
>>    pointer.
>>
>> - Verify that our csum type didn't change before checking the csum
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to misc-next, thanks. Can you please also send a test case?

The test case is a little complex.

Freeze an fs is easy, but there aren't so many easy ways to modify the
super block like modifying it when it's still mounted.

We can do something like wiping the superblock, but it's much harder to
cover all the error paths.

Thanks,
Qu
>
>> ---
>>   fs/btrfs/disk-io.c | 10 ++++------
>>   fs/btrfs/disk-io.h |  2 ++
>>   fs/btrfs/super.c   | 16 ++++++++++++++++
>>   3 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 9f526841c68b..5bf373f606e0 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -166,11 +166,9 @@ static bool btrfs_supported_super_csum(u16 csum_ty=
pe)
>>    * Return 0 if the superblock checksum type matches the checksum valu=
e of that
>>    * algorithm. Pass the raw disk superblock data.
>>    */
>> -static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>> -				  char *raw_disk_sb)
>> +int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>> +			   struct btrfs_super_block *disk_sb)
>
> 			   const
>
>>   {
>> -	struct btrfs_super_block *disk_sb =3D
>> -		(struct btrfs_super_block *)raw_disk_sb;
>>   	char result[BTRFS_CSUM_SIZE];
>>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>
>> @@ -181,7 +179,7 @@ static int btrfs_check_super_csum(struct btrfs_fs_i=
nfo *fs_info,
>>   	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space is
>>   	 * filled with zeros and is included in the checksum.
>>   	 */
>> -	crypto_shash_digest(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
>> +	crypto_shash_digest(shash, (u8 *)disk_sb + BTRFS_CSUM_SIZE,
>
> 				   (const u8 *)
>
>>   			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
>>
>>   	if (memcmp(disk_sb->csum, result, fs_info->csum_size))
