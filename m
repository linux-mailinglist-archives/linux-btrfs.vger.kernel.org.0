Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F360EB95
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Oct 2022 00:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiJZW3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 18:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJZW3t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 18:29:49 -0400
Received: from fallback17.mail.ru (fallback17.m.smailru.net [94.100.176.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FF49FC2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 15:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=VsJh4ZRI6UEzSHk3827PE/PzeyxmHxU1bBsYTwyFVKY=;
        t=1666823384;x=1666913384; 
        b=RyrTHHRD7aDsoXDtvQ+jC9ygtraVLUAVo9ci7ZWZJmS59B/5BsprsdttoqhaL1h99GG5zajXox2uftVQ19RBHdMlAD+hAscqJADD4zhbifR6U4CH/2Wh9RnaVTJcXPgXpe2y4xNRddzx0o7TX2RH1PyyCWQg0jR3KpKrbbmFCPJfbx4JHom6+bLFrv8opQaEtA+p2NnznylX6Ea1HlAuyzGqtQoysug1H0yCm2XOBqVN4Rw3EmSal3Qd21Y451jKhL5N4CpeiR17wghF4zxVGS28DlRSoV7pBC0DIrSMQ7Wbccfulzr7pfU8ZusdV9dX6lp2M37J+8ZV5XOMIwnFcA==;
Received: from [10.12.4.3] (port=34870 helo=smtp17.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1onou5-0003jT-JP
        for linux-btrfs@vger.kernel.org; Thu, 27 Oct 2022 01:29:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=VsJh4ZRI6UEzSHk3827PE/PzeyxmHxU1bBsYTwyFVKY=;
        t=1666823381;x=1666913381; 
        b=kEhmskJEz22TQrcc3Z1uSX573RHdTE/30rl1bq0v/EIt01hrWitswmert2yxaF87HLjWGAgX+sRLnDjs3gAofxxfr/AAdIrwRgVJ1BSbb9ZvblSmy458hoe49fjiaxhnsYcRjzySk26Qp4DMPdfCqu45ff+vo4kT/m4onybpfv7202eWoVU76bQemJ968I7NACqf/5NJbzQGoH5Ru8VA9PBLzsaAAnD2rtdp2E3DMKeHQ9L38EP922dJDJxqoeq9/dwXsXtLXBJXpz3kiVGi/bzE9/asitS6EHO3L74Am3H9XYXmzOyhkn6+YF4ugz6wgmk8ll/K2Wv8D2WV+gBWoA==;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <Nemcev_Aleksey@inbox.ru>)
        id 1onou0-007nsk-KV; Thu, 27 Oct 2022 01:29:37 +0300
Message-ID: <fa62c9cb-0fe9-b838-3f69-477dc61dbd45@inbox.ru>
Date:   Thu, 27 Oct 2022 01:29:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: compsize reports that filesystem uses zlib compression, while I
 set zstd compression everywhere
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3c352b84-c52a-9e01-1ace-6e984e167753@inbox.ru>
 <eee8a8e1-8e54-4170-af44-a94c524c37ad@app.fastmail.com>
From:   Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>
In-Reply-To: <eee8a8e1-8e54-4170-af44-a94c524c37ad@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9BAEAA343CB33328DC876FBED9A983553E4DA5BC0DBB83466182A05F538085040693332E135556EC98F73B22BB82719B258DE09950EB0999797B32951628E18BF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75D1285FE9E48A518EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C867FEFF36BCDF178638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89834C0141459E2A766398619D585B1756F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7A6779F98BF527B7A9FA2833FD35BB23D9E625A9149C048EE7B96B19DC4093321618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B60CDF180582EB8FBA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC6D77D8F98F67F34ED81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636D81D268191BDAD3D78DA827A17800CE730067454D0D048C4EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3A09867D54EC1DC4935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34C0DDD40374D3501738ED3B7872D30745535CD6A7E10E4A5461280F71794C761D3A0412965F9A07CA1D7E09C32AA3244C3A751289375761FC40FD8CA4F5DC9D74F2F5F14F68F1805B729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojn29rKCpnMbhciZflQ9OoJg==
X-Mailru-Sender: 6F30CE3AAFA23F85D1B9D8D23F7101C4911CFE84507CE1B7B02898577481B319781AA8E811C093F9B5D628A7EF4494575C5F6E3C72ABB53BB0D9B300F142F0238EAA47040EB6BC244E4EA347F45ED768B49EAA7E57EF395FB4A721A3011E896F
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4D39C97B71A9E5B92E5C3C2F3BD609EFF6BCC237A4890FD22049FFFDB7839CE9EABEED22FEB827D90353F1BA33DD4410F518F4D584E2D182A0DEBCA75BFE4884E
X-7FA49CB5: 0D63561A33F958A5F40467D489D31FB32BD7088A40D0078D0FC6A4573E93D226CACD7DF95DA8FC8BD5E8D9A59859A8B634143DAF28A1E3E7CC7F00164DA146DAFE8445B8C89999728AA50765F79006370A32D918A17158F1389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8B6FBD635917D924DF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C13BDA61BF53F5E1DAD7EC71F1DB884274AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B642CC182D4119DD0F089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojn29rKCpnMbj6e6+fVflUyA==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

26.10.2022 22:07, Chris Murphy пишет:
>
> On Wed, Oct 26, 2022, at 6:21 AM, Nemcev Aleksey wrote:
>> Hello.
>>
>> Recently I decided to compress the existing Btrfs volume with zstd.
>>
>> To do this, I set property `compression=zstd` for all subvolumes to
>> compress new files with the default zstd:3 compression level.
>>
>> Then I run `btrfs filesystem defragment -c zstd:12 -v -r` on all
>> subvolumes to compress existing files using zstd:12 compression level
>> (to spend more time now and save more space later, but don't want to
>> keep slow zstd:12 level all the time).
>>
>> After defragment, I run `btrfs filesystem balance` on all subvolumes to
>> make Btrfs happy.
>>
>> And after all, I run `compsize` on the root subvolume to check the
>> compression ratio, and compsize shows me the following:
>> Processed 1100578 files, 1393995 regular extents (1649430 refs), 666312
>> inline.
>> Type      Perc    Disk Usage  Uncompressed Referenced
>> TOTAL      77%     169G        217G        226G
>> none      100%      99G         99G        100G
>> zlib       52%      54G        102G        109G
>> zstd       19%      12M         65M         66M
>> prealloc  100%      15G         15G         16G
>>
>> I'm very confused why almost all compressed data is compressed with zlib
>> while I haven't used zlib at any step.
>> Why do compsize reports this?
>> Should I worry about this? It seems zstd offers a much faster
>> decompression speed than zlib.
>> Thank you.
>
> If you use chattr +c anywhere, it uses the btrfs default compression algo which is zlib. There is a way to set a compression algo property, but I'm uncertain if the kernel honors it.
>
> So you'll want to recursively remove the compression file attribute. I'm not sure it's worth recompressing but you can use defrag -z for that.
>
Thank you for the idea, I understood where I failed.

`btrfs filesystem defragment -c zstd -r /` is not correct command, but 
`btrfs filesystem defragment -czstd -r /` is correct one (note the space).

And the first command will try to defragment the file named zstd using 
default compression (zlib), not the compression from the `compression` 
subvolume property.

And also it's not possible to specify compression level in defragment - 
so, I'll change the level in subvolume properties, defragment with 
-czstd, and change the level back.
