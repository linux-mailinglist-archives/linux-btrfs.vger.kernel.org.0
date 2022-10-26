Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9260DECF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiJZKWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 06:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJZKWC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 06:22:02 -0400
Received: from fallback16.mail.ru (fallback16.mail.ru [94.100.177.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13A971BCB
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=qOr+G3ZH0fK149IHu0NH3DVUg6kLXm6zS+Unvs/npUY=;
        t=1666779720;x=1666869720; 
        b=GXlsnNIskuRwXq5CucZR379qCwnLlQ7A6jKuDIb8Byo+HNmU+DSyc/RL7kiGpTfeG/q+lm7K7nur1STm8mNDFUanO/ak5GPGVBpWLZGo3Fbt+RunRrcjQlIcFwQg2wvyvs2jkbwG1f0mkeCxbb+q03WUpEHJEXN1ao09aSGqtS3y77eUEGwf1Db2DEEwjd286/Lk5rG5wp7u44QJmVNw+BLbmK/Q2xyXtB4hGAjr/ZfphTIJDSx05VS6DbhHNRhv8qSdn9GBQDhjTjC8+QJrP2MrIldqhCmTu6x2WWO0bkwWDo82/UTgQyGeXNRFC4dWiMz7NSv7Y4lfuquQ48qHtg==;
Received: from [10.161.64.40] (port=35808 helo=smtp32.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1ondXp-0001vf-UJ
        for linux-btrfs@vger.kernel.org; Wed, 26 Oct 2022 13:21:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=qOr+G3ZH0fK149IHu0NH3DVUg6kLXm6zS+Unvs/npUY=;
        t=1666779717;x=1666869717; 
        b=aGsqTXequasbrurAKuFzUEx0dkx13m2ZPHKrNgmlGHfl4mjC4j+Ierl2PSrwqgzwPg5+61WOKHa9GtQb5ykMxu+4J0x6p9VEg98JU9NncfiCcQn0+5oA3arrrNfjIx4XzlpLHTquP8LcfHZ4mQrDSkFeyvaVxvSd8A63XTdwEV954wOz0gzvA60JXka42HHg3oT4fp3MBexTSvldoWCI3FvJvEMZ7Fptwb6t48aN880B9rjErMrPw9OuLYYPyLnvY9GxozkxK+ANGunjPKWz+G4rF2zZYq00YLRgGil42km0pawWbIDxweqU9cC34LeGk6sZE9upPEmQBi/L6MLTWQ==;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1ondXl-0005P6-Kl
        for linux-btrfs@vger.kernel.org; Wed, 26 Oct 2022 13:21:54 +0300
Message-ID: <3c352b84-c52a-9e01-1ace-6e984e167753@inbox.ru>
Date:   Wed, 26 Oct 2022 13:21:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
Subject: compsize reports that filesystem uses zlib compression, while I set
 zstd compression everywhere
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD97F9382DBE4976309677200326EC5B0147BDE9CF1913DD5C9182A05F538085040F739EC3F71C418746E013EB4DD6A205338043614A444737704141A390FC9D3D5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BF5628FE6781D09AEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D99F96657F58F1038638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C55636AAEE020FC7092E2DD6E9D5B0FC6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE74601F13E4625331C9FA2833FD35BB23D9E625A9149C048EE91ADC097FE2C3A0828451B159A507268D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B9FC99A4BA45EE8B4A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCC48E0A8B6940832C3AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637451D7A1424C03B48D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F4AF35CDC74363304262FEC7FBD7D1F5BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5FD8D47440C1834D5A67B693F76D0AEE71C0B2229ED0C5B464EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34682FD2D2951524C5E2FBAE0949E336851C0A23EB1331CD97D3661D62E2354B13837146100FC738171D7E09C32AA3244C77D93B9DE79C124B478728D598F2BD61250262A5EE9971B03EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojjp7lQEaJ71DVhZzuw2Vvjg==
X-Mailru-Sender: 6F30CE3AAFA23F85D1B9D8D23F7101C436CACADA7494C54518635E1978651147A68455F3213666EEB5D628A7EF4494575C5F6E3C72ABB53BB0D9B300F142F0238EAA47040EB6BC244E4EA347F45ED768B49EAA7E57EF395FB4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B43D3FA0ACCFBC07C6089038BDC79390D89FF925C7B324A25B049FFFDB7839CE9EABEED22FEB827D90A78F94D8841B75E539E8B76DF185158391D45B2C8D91F08B
X-7FA49CB5: 0D63561A33F958A54538802D9A72B6CC6A8D4EED06C69900CDB350BA0B9FE517CACD7DF95DA8FC8BD5E8D9A59859A8B68F8E560BB31819B2
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdJleViSEgp/TPtl/NCkxEcQ==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello.

Recently I decided to compress the existing Btrfs volume with zstd.

To do this, I set property `compression=zstd` for all subvolumes to 
compress new files with the default zstd:3 compression level.

Then I run `btrfs filesystem defragment -c zstd:12 -v -r` on all 
subvolumes to compress existing files using zstd:12 compression level 
(to spend more time now and save more space later, but don't want to 
keep slow zstd:12 level all the time).

After defragment, I run `btrfs filesystem balance` on all subvolumes to 
make Btrfs happy.

And after all, I run `compsize` on the root subvolume to check the 
compression ratio, and compsize shows me the following:
Processed 1100578 files, 1393995 regular extents (1649430 refs), 666312 
inline.
Type      Perc    Disk Usage  Uncompressed Referenced
TOTAL      77%     169G        217G        226G
none      100%      99G         99G        100G
zlib       52%      54G        102G        109G
zstd       19%      12M         65M         66M
prealloc  100%      15G         15G         16G

I'm very confused why almost all compressed data is compressed with zlib 
while I haven't used zlib at any step.
Why do compsize reports this?
Should I worry about this? It seems zstd offers a much faster 
decompression speed than zlib.
Thank you.
