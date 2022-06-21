Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD6552917
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 03:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbiFUBnb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 21:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiFUBnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 21:43:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B033FD1C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655775794;
        bh=GCKoWPboKoxzshozzJisfkiomSxe8xHEIdy8MEDe7xE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=XpCMpZUnc8gr2gOw1kka7Ywe2iU7P3XVTPIPPyYrnAORzQNpJ6TySZx8XrTu2Qnvu
         sMyMvz9YNzV19nb+9iqD/IJ00FyBLc22T7Y5tHvUMuRQB/TYHXouohHaJ/0exXMJrR
         4Chj92g7yi0I/xblX+QRj4sKX3eocdiC4UfxJrUQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWRVh-1oAOoU1fOF-00XrCc; Tue, 21
 Jun 2022 03:43:14 +0200
Message-ID: <bbe1a5c2-96d2-234a-c446-ade414842e06@gmx.com>
Date:   Tue, 21 Jun 2022 09:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: zlib: refactor how we prepare the input buffer
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
References: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
 <20220620160806.GS20633@twin.jikos.cz>
 <7bd3daa0-234d-4843-0f04-2b020f1c7b0e@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7bd3daa0-234d-4843-0f04-2b020f1c7b0e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TUgreQucB3qLFXLa0FEQ6F9qyt9uQo3icl8haMN0H/W85uv274F
 VCDiLlD5ofYM7KHKziZU3bVOKAvOqu3svvU8+zMfpQbXi7vm0l5YRHnQF2QSNBTLclRVNvh
 P5vcvWNs/O1cNP805Gd83BxO19IDOA+fyBZdWMpQgh5g/ysGio3exb7EL/yUpORPypAZdt4
 LMjhJhNLkf3/5Vi8yaPrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/fcV/XijOZQ=:gBZzj6bfc6ednfpsVneudp
 mjg7JLFC9+03u1fj8ESPeLuZ0p7hMjGGi6EonbgG0wdtuyUWwtGH6LM/40SPain1/0TUj2rhE
 5biGWYPZIo1JcStBu0FAxEZMpFtizskbCb5IRFoWInw0KuNob1fLfx7EwC9N0sBMRiCOSyJeh
 QU79PdngKH2xsYQvIMAdbHPrtSUs1bLKAFKcvl9LN8LF2GmT6Jr08Zk340EHZU6ioQNkHQHfZ
 LM38h2YbBbuUr+IF7YHvNhRsrNiJ/TFgYQk0Zaa2pomn66Nyoywg3hx8ubWpXf49FJqt/NlmI
 h/29hxXvygH5GuIHzeTlTJ5f9IFS6uaCRVxiOf2i2rCfbS5PvpdFrt/kdKTHixiRPmxxRm6fi
 Y0PKyjK/fKUzZjPlYcieZuzHibpt47zsDpX+5My8rKzmPWQ0iQ8w80+ZP2R2YIdDfuKX5OyKZ
 jpYFurhzOxJNuxTptnum6OqKiWjPSlDumKGFwj2k3i8XF7a9d8qEzRkzpMvnfQSVCXjS/5q6H
 2L72BW0yW4mzTWaBilfqDFDWWez0ySAkGyj2XVUYGHDkTsS+caPlTiQ8Frn+F8yUS++xnZSWZ
 eALU5MVrjzm6Sstg6V3IE7spi+yp8nYySnZnKZk82yyRAj+EJTSL8nllFqug+tZsCNMggfw/l
 wQRiUb/rluYAV7R9kwdFezpz1UaMm34ynzEqaH8/NvKPrGwFUxguAzbu/dTXHevl17W+kvCn/
 BxJVpoLNZpS2mvolgu7kpovM/hhbTkQ0bZmHfiJGMMbdY3/9iV0uY8rhO/VOpXpqkKIvQv8K7
 p9PPA1EUn97wO+YeJ/mOwnlLa5qrwKaaPUuNfMTUNzQDpgsUIGaHLA4eJffasZzsXaCMHwgYG
 G8iac2R4D6um8PIpltHhjUvGrM6bMyP0d3RtIqxlTgO6gEx0KcCzVHtX/DLPvtaLHAjRR7wlp
 hweC51BVX0PrG4t7yzJEI9BskwqC3QNNSLbk5CvHkPgFEHuUNJSXCG0uRhc+w3XdX/qFh5ucM
 hSXp62r/KEds5EFoLDxBqliu0r9uSDfa69sJhAXbj+rMrV1Q+hk8xTYp9OAcqzODYX9uT3Ee4
 eANm1OdI9Za6ufpOR6pi378PDPho3+1kZpZrk5e7g7t2P+UiuP9DgDdDA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/21 08:40, Qu Wenruo wrote:
>
>
> On 2022/6/21 00:08, David Sterba wrote:
>> On Sat, Jun 18, 2022 at 10:39:28AM +0800, Qu Wenruo wrote:
>>> Inspired by recent kmap() change from Fabio M. De Francesco.
>>>
>>> There are some weird behavior in zlib_compress_pages(), mostly around
>>> how
>>> we prepare the input buffer.
>>>
>>> [BEFORE]
>>> - We hold a page mapped for a long time
>>> =C2=A0=C2=A0 This is making it much harder to convert kmap() to kmap_l=
ocal_page(),
>>> =C2=A0=C2=A0 as such long mapped page can lead to nested mapped page.
>>>
>>> - Different paths in the name of "optimization"
>>> =C2=A0=C2=A0 When we ran out of input buffer, we will grab the new inp=
ut with two
>>> =C2=A0=C2=A0 different paths:
>>>
>>> =C2=A0=C2=A0 * If there are more than one pages left, we copy the cont=
ent into the
>>> =C2=A0=C2=A0=C2=A0=C2=A0 input buffer.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 This behavior is introduced mostly for S390, =
as that arch needs
>>> =C2=A0=C2=A0=C2=A0=C2=A0 multiple pages as input buffer for hardware d=
ecompression.
>>>
>>> =C2=A0=C2=A0 * If there is only one page left, we use that page from p=
age cache
>>> =C2=A0=C2=A0=C2=A0=C2=A0 directly without copying the content.
>>>
>>> =C2=A0=C2=A0 This is making page map/unmap much harder, especially due=
 the latter
>>> =C2=A0=C2=A0 case.
>>>
>>> [AFTER]
>>> This patch will change the behavior by introducing a new helper, to
>>> fulfill the input buffer:
>>>
>>> - Only map one page when we do the content copy
>>>
>>> - Unified path, by always copying the page content into workspace
>>> =C2=A0=C2=A0 input buffer
>>> =C2=A0=C2=A0 Yes, we're doing extra page copying. But the original opt=
imization
>>> =C2=A0=C2=A0 only work for the last page of the input range.
>>>
>>> =C2=A0=C2=A0 Thus I'd say the sacrifice is already not that big.
>>
>> I don't like that the performance may drop and that there's extra memor=
y
>> copyiing when not absolutely needed, OTOH it's in zlib code and I think
>> though it's in use today, the zstd is a sufficient replacement so the
>> perf drop should have low impact.
>
> My bad, I didn't check buf_size which is conditionally assigned to
> PAGE_SIZE or 4 * PAGE_SIZE.
>
> So changing it to memcpy() is going affect all archs other than S390.
>
> I'll change the mapping start and end part to re-enable the old behavior=
.

Then the things can get super complex as the original purpose from
Fabio, the nest mapping is our biggest enemy.

For input and output page, we can no guarantee the sequence how they get
mapped/unmapped.

But kmap_local_page() requires the reverse order to unmap them, making
things super complex.

Thus I'd say, either we go the memcpy() path, sacrifice some performance
for the easier to read code, or we always map/unmap the input and output
pages every time we call zlib_deflate().

Thanks,
Qu

>
>>
>>> - Use kmap_local_page() and kunmap_local() instead
>>> =C2=A0=C2=A0 Now the lifespan for the mapped page is only during memcp=
y() call,
>>> =C2=A0=C2=A0 we're definitely fine to use kmap_local_page()/kunmap_loc=
al().
>>>
>>> Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Only tested on x86_64 for the correctness of the new helper.
>>>
>>> But considering how small the window we need the page to be mapped, I
>>> think it should also work for x86 without any problem.
>>> ---
>>> =C2=A0 fs/btrfs/zlib.c | 85 ++++++++++++++++++++++++------------------=
-------
>>> =C2=A0 1 file changed, 41 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>>> index 767a0c6c9694..2cd4f6fb1537 100644
>>> --- a/fs/btrfs/zlib.c
>>> +++ b/fs/btrfs/zlib.c
>>> @@ -91,20 +91,54 @@ struct list_head *zlib_alloc_workspace(unsigned
>>> int level)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ERR_PTR(-ENOMEM);
>>> =C2=A0 }
>>>
>>> +/*
>>> + * Copy the content from page cache into @workspace->buf.
>>> + *
>>> + * @total_in:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The original =
total input length.
>>> + * @fileoff_ret:=C2=A0=C2=A0=C2=A0 The file offset.
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
Will be increased by the number of bytes we read.
>>> + */
>>> +static void fill_input_buffer(struct workspace *workspace,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space *mapping,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long total_in, u64 *fileoff_ret=
)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned long bytes_left =3D total_in - workspace-=
>strm.total_in;
>>> +=C2=A0=C2=A0=C2=A0 const int input_pages =3D min(DIV_ROUND_UP(bytes_l=
eft, PAGE_SIZE),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workspace->buf_size / PAGE_S=
IZE);
>>> +=C2=A0=C2=A0=C2=A0 u64 file_offset =3D *fileoff_ret;
>>> +=C2=A0=C2=A0=C2=A0 int i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Copy the content of each page into the input bu=
ffer. */
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < input_pages; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct page *in_page;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *addr;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in_page =3D find_get_page(=
mapping, file_offset >> PAGE_SHIFT);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D kmap_local_page(i=
n_page);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(workspace->buf + i =
* PAGE_SIZE, addr, PAGE_SIZE);
>>
>> The workspace->buf is 1 page or 4 pages for x390, so here it looks
>> confusing that it could overflow and no bounds are explicitly checked
>> wherether the i * PAGE_SIZE offset is still OK. This would at least
>> deserve a comment and some runtime checks.
>
> The check is just above, @input_pages is calculated using
> workspace->buf_size / PAGE_SIZE.
>
> So it should be OK.
>
> Although the real problem is subpage support, we should not just copy
> the full page.
>
> But thankfully, btrfs subpage only support full page compression for now=
.
>
> Thanks,
> Qu
>
