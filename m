Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAB6E5765
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 04:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjDRCQ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 22:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDRCQ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 22:16:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED6640EC
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 19:16:54 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7zFj-1qSD4H0icF-0150Mo; Tue, 18
 Apr 2023 04:16:46 +0200
Message-ID: <e4838b8f-e939-9c11-85d5-2d05e3d58022@gmx.com>
Date:   Tue, 18 Apr 2023 10:16:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        u-boot@lists.denx.de
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
 <20230418-btrfs-extent-reads-v1-1-47ba9839f0cc@codewreck.org>
 <ad41862c-e7fb-acd7-7657-85b76cb302ee@gmx.com>
 <ZD364ycA71hLmmOK@atmark-techno.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH U-BOOT 1/3] btrfs: fix offset within
 btrfs_read_extent_reg()
In-Reply-To: <ZD364ycA71hLmmOK@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pEruPea8qSJw4suKvXpe8ItYEEXX7O3hGrLhL0z4LLobNSbtbws
 UykpJag2jZBmBBu/vfbBiiJsyam55KH0GRejT1t1AAM6/D9BNQygneioo9vIBRSOivZODgv
 Jy4fCEPTbGpyuiW5b57gB7Iox+d8B8mVgKY4max10J6uY/p1CGI3GnXvH1Fh31VmC/hy47D
 W0AQ+lx/Ihi6QnILZ1AVA==
UI-OutboundReport: notjunk:1;M01:P0:yLwRF16sFpQ=;hPObOGmA2QIi4Ve6t51bg9vwAEi
 r1iO7/CWvfhXZiEVEVTz02xWJIRrfVJ4jMNI4l946SQXdGXSX9OqBw2bW2fNGKhvH5Os5NhuI
 2u3nrJGGlmnYNSQz+97opFUQMdHgPKasc2Zog0OivwX2Kf/3YHOQ4ZZqoz0km6jK9TDud+ASp
 UyOBBK5Plmt0Rr4Jv09mxv8tVspzmyrsaxXmME7keWsvsPCihpn1AC6y24j46dG5GXT0RGSUj
 dC4sSk6xGM+k0bQPHjhKPP5wWhlzglOlGxQflOlYNL6XxaHd9X08HKnL9w7h6kO6OrsDsocsY
 wt3O99hbQYjM55zGYPqErYew4Xiu6Wk9wVC35al/MpZXGGZJaarufuW/qnsApfUk57vHu2dSy
 nuJfjst6tH9A03OhEkLqcmlVT1KwxJg7NL5V2jHbOHAlP3qsBNHsHe3XuAzsSfFWZV8VX8FZq
 93Z+vDxaIm93NNiGLwqzgCzFY8OBTrjPlvboocdQjucfqRtNo9SEVnvArtYGtmikAsrQ2jm7d
 0xlUg5oYkIQZV3u+wOxGtIqUh0IGUNqWYS/vbPhpRIIeyLEoWfZiuji3qD5B17ZlRV9BorTvb
 NUJm/mqjUpkiiprog+2Yy/LH/BUa3mvu0JA+rnNd5lSbmsSWs3rix2aDosnnncG3QRHYTdEsG
 ltVI0CU41fgL7IP2iCgIaUq56YrrnNIwhf3EfsFZrWSYTUS4UlP0dX8qjvC04wiVm+IThpuWr
 uN3+eBBd45r1SSySktVp55t1eB1VfKicKCuSekxw4KaGdcwzDJRTszB5milv4Eun//mpyChrw
 bXz4EhXA4AoQuV5itJ3on1zpZahwhNDRwKG3WrL78Y31yhgqj0xFgvbl2n8pLCwj9JTlukwgn
 il4XeSkLjYMeHhFLQMP0sh9Ov9tJT9z7MBS+coqm2XjBM+YcKsnfyWWtuV0NveglJSepZFlqI
 52pXCr/CoP6qqHqHxSX3UG0YKFE=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 10:05, Dominique Martinet wrote:
> Qu Wenruo wrote on Tue, Apr 18, 2023 at 09:58:37AM +0800:
>> The subject can be changed to "btrfs: fix offset when reading compressed
>> extents".
>> The original one is a little too generic.
> 
> Ok.
> 
>>> btrfs_file_read()
>>>    -> btrfs_read_extent_reg
>>>       (aligned part loop from 0x40480000 to 0x40ba0000, 128KB at a time)
>>>        last read had 0x4000 bytes in extent, but aligned_end - cur limited
>>>        the read to 0x3000 (offset 0x720000)
>>>    -> read_and_truncate_page
>>>      -> btrfs_read_extent_reg
>>>         reading the last 0x1000 bytes from offset 0x73000 (end of the
>>>         previous 0x4000) into 0x40ba3000
>>>         here key.offset = 0x70000 so we need to use it to recover the
>>>         0x3000 offset.
>>
>> You can use "btrfs ins dump-tree" to provide a much easier to read on-disk
>> data layout.
> 
> key.offset is the offset within the read call, not the offset on disk.
> The file on disk looks perfectly normal, the condition to trigger the
> bug is to have a file which size is not sector-aligned and where the
> last extent is bigger than a sector.

Yes, I understand the runtime offset is involved.

But you're still trying to explain the situation with involved on-disk 
file extent, right?

In that case it's way easier to go something like this:

   We can have a compressed file extent like this:

	item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
		generation 7 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 0 nr 32768 ram 32768
		extent compression 1 (zlib)

   Then if we try to read file range [4K, 8K) of inode 257 in Uboot, then
   we got corrupted data.

At least that's the preferred way to explain in btrfs community (with 
on-disk thus static part, then runtime part).

> 
> I had a look at dump-tree early on and couldn't actually find my file in
> there, now the problem is understood it should be easy to make a
> reproducer so I'll add this info and commands needed to reproduce (+ a
> link to a fs image just in case) in v2

The reproducer is super easy.

  # mkfs.btrfs -f $dev
  # mount $dev -o compress $mnt
  # xfs_io -f -c "pwrite -i /dev/urandom 0 16K" $mnt/file
  # umount $mnt

Then in uboot
  # load host 0 $addr file 0x1000 0x1000
  # md $addr

And compare to regular xxd from kernel.

>   
>>>    	/* Preallocated or hole , fill @dest with zero */
>>>    	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_PREALLOC ||
>>> @@ -454,9 +456,7 @@ int btrfs_read_extent_reg(struct btrfs_path *path,
>>>    	if (btrfs_file_extent_compression(leaf, fi) == BTRFS_COMPRESS_NONE) {
>>>    		u64 logical;
>>> -		logical = btrfs_file_extent_disk_bytenr(leaf, fi) +
>>> -			  btrfs_file_extent_offset(leaf, fi) +
>>> -			  offset - key.offset;
>>> +		logical = btrfs_file_extent_disk_bytenr(leaf, fi) + offset;
>>
>> This is touching non-compressed path, which is very weird as your commit
>> message said this part is correct.
> 
> my rationale is that since this was considered once but forgotten the
> other time it'll be easy to add yet another code path that forgets it
> later, but I guess it won't change much anyway -- I'll fix the patch
> making it explicit again.

OK, that makes sense now.

Thanks,
Qu

> 
> 
> Thanks,
