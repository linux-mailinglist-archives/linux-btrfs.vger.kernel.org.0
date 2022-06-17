Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C0154FFC3
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiFQWQh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 18:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQWQg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 18:16:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E358E5F;
        Fri, 17 Jun 2022 15:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655504184;
        bh=1zuZo17yQkJ4UonOeU2RtRocYcJmCWHTL/EIH5YEV28=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=Nu5zgEVSGUyD41EScqAnpNUDp5d8NZrXiX386SgDOC0liMIZpOLD7PBofLOLfxZ9M
         iR9bNV+A2E56cnzvzMBLhizvrB3D/TlrtBbwWc8SZOmYMc4n62TyUxaqNNjcoinzEA
         RIrxPjjlUb0s7YUoQCGn2A21xlNxhOsZTy5GeHME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsYux-1nj8ge2jwR-00u3jE; Sat, 18
 Jun 2022 00:16:24 +0200
Message-ID: <94f8d618-ec7a-f68e-c302-2639ae3d7549@gmx.com>
Date:   Sat, 18 Jun 2022 06:16:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220617120538.18091-1-fmdefrancesco@gmail.com>
 <20220617120538.18091-4-fmdefrancesco@gmail.com>
 <8cbfc1ff-f86d-f2cc-d37e-ef874f4600bc@gmx.com> <14654011.tv2OnDr8pf@opensuse>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC PATCH v2 3/3] btrfs: Use kmap_local_page() on "in_page" in
 zlib_compress_pages()
In-Reply-To: <14654011.tv2OnDr8pf@opensuse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T3AWC4njoZEfrQGkSjPULUpIoCzpmdwWypJW4ohMv5CdvtPfv4f
 ShmSkMHlxk+phdGNazCMjajaoa2D3sFnVls7hAQcABC0GcRB9O9fsG4hBOqHnIcVV9xzicr
 mqzlKC/Vuab4D6GUeUXeici1PThNe19QNQyZ5VrpNtqXYJE8w/AoWU3F6AM2Xsli0CxuVOn
 ZghQhz/vuiTuFnaQr4fQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Dxt56PQQKc=:h6986K481FP2pcAIhkfDOj
 Vo6qi74/eRV40qTbd64sMnev3XEBObdNWVD/FSKL9igZY05D5SyB6MchIg8mnTPq85TeUkFqp
 vihsVv68Q40Bn9r/umWziXwFN0lC/fMxslRJ1NqF2jbHGtDfiZ5N7NXAw1hyqsQyG0KObsYZx
 8wNP0GjMJqLrPeCC43CaS38LAAPEWmzUP4uLUWLxHWiwjuk3dz48Ay6WuxU1SgJRhCiEHkxWa
 Ue8r9knQf34hvTcKTrh8075fDOwQb5/o8mhpWCc/XU3AeqdDtuXXtS8UNlg8kgke16IkfBzeY
 TkFvLSHqajrVTvQdpfi7LyAtv0JIs0MoHEKzWWQb9QA+HcD8FKcvRP2e1ew+aBRR+LBljc+NF
 g11lrU4SBDxzY8NFYErP1NRzRdhAt09xk7X39a4d7H7GCN8+ZkD9lJ5eY65dW7w0sjew6PN9/
 7L3q/szjRJnWQWT8Ea3ngcGWmFiw0rcCMJPiElmvUo5Fo68ziyCe06kpML+JohzY0RA7BgPLO
 ss77SmCkpo0EZ/AxYL0xBYz/PbbE/MFb+ad34sFog/scHQ5mqoIeceLWqiBhfIzq6PRvrD67l
 8xFv5SG17AF920D8C1YJ8X3yACAmzTDfYudC6ZvTH63x5oGvaZIc6bC5RtVoVgzR0iM2M0rGM
 uSdZm3A+TSYUClfI2lVOuacEGc8nBC2kYJY5FPRrBJQWnbG0oQHqNtXL8eCgZN3y1pO8Bx5Pm
 ej3mCzv7SoNAiuOjpfx4AjUsS2JXAgJVjUK99ZDT260EUHlFvtvrgYfqk7Mr8mTCYT4ZpTeDX
 OH8Ylgp6JPfSBQwMH9PFR71DmKeGQjkQM/dWc6BazRLmedJXAu8LYhMCUSVSkLLshYudpYx4R
 ViOUgzDToIup3VA/fTzXefBBjRHYn82Ul3Hb8+YpKrIayMo0IA5ZXWlWZq4DIOw9le4n+IrAD
 OH3ZQ7ITt1IxsubTZvSc0/M1EEApV2alCpSJRqIfgzkQXikuNHdSwAC+x4m8NNKaVlcnid0iP
 VY0VcahlPgn25rIKFUstJB/BPG24R1Bmwfw/g1jkWCbNbM+Hn9eJOUKxaBYF1sXdhRsT/Ee7U
 hMATP1vLHWCsN3B+qEVj28ph2RcpSpnjYs7AQL33IggH97wgskN3N1P2g==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/18 02:13, Fabio M. De Francesco wrote:
> On venerd=C3=AC 17 giugno 2022 15:09:47 CEST Qu Wenruo wrote:
>>
>> On 2022/6/17 20:05, Fabio M. De Francesco wrote:
>>> The use of kmap() is being deprecated in favor of kmap_local_page().
> With
>>> kmap_local_page(), the mapping is per thread, CPU local and not
> globally
>>> visible.
>>>
>>> Therefore, use kmap_local_page() / kunmap_local() on "in_page" in
>>> zlib_compress_pages() because in this function the mappings are per
> thread
>>> and are not visible in other contexts.
>>>
>>> Use an array based stack in order to take note of the order of mapping=
s
>>> and un-mappings to comply to the rules of nesting local mappings.
>>
>> Any extra comment on the "rules of nesting local mappings" part?
>>
>
> Actually, I'm not sure about what to add. I thought that whoever need mo=
re
> information about LIFO mappings / un-mappings can look at highmem.rst. I=
've
> changed that document and now it contains information on why and how to =
use
> kmap_local_page() in place of kmap() and kmap_atomic().
>
> Am I misunderstanding what you are trying to say? If so, any specific
> suggestions would be greatly appreciated.

Thanks for pointing to the doc, and that doc is enough to answer my
question.

>
>>>
>>> Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
>>> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
>>>
>>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>>> ---
>>>    fs/btrfs/zlib.c | 65 +++++++++++++++++++++++++++++++++++++++
> +---------
>>>    1 file changed, 53 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>>> index c7c69ce4a1a9..1f16014e8ff3 100644
>>> --- a/fs/btrfs/zlib.c
>>> +++ b/fs/btrfs/zlib.c
>>> @@ -99,6 +99,8 @@ int zlib_compress_pages(struct list_head *ws, struct
> address_space *mapping,
>>>    	int ret;
>>>    	char *data_in =3D NULL;
>>>    	char *cpage_out =3D NULL;
>>> +	char mstack[2];
>>> +	int sind =3D 0;
>>>    	int nr_pages =3D 0;
>>>    	struct page *in_page =3D NULL;
>>>    	struct page *out_page =3D NULL;
>>> @@ -126,6 +128,8 @@ int zlib_compress_pages(struct list_head *ws,
> struct address_space *mapping,
>>>    		ret =3D -ENOMEM;
>>>    		goto out;
>>>    	}
>>> +	mstack[sind] =3D 'A';
>>> +	sind++;
>>>    	cpage_out =3D kmap_local_page(out_page);
>>>    	pages[0] =3D out_page;
>>>    	nr_pages =3D 1;
>>> @@ -148,26 +152,32 @@ int zlib_compress_pages(struct list_head *ws,
> struct address_space *mapping,
>>>    				int i;
>>>
>>>    				for (i =3D 0; i < in_buf_pages; i++)
> {
>>> -					if (in_page) {
>>> -
> kunmap(in_page);
>>
>> I don't think we really need to keep @in_page mapped for that long.
>>
>> We only need the input pages (pages from inode page cache) when we run
>> out of input.
>>
>> So what we really need is just to map the input, copy the data to
>> buffer, unmap the page.
>>
>>> +					if (data_in) {
>>> +						sind--;
>>> +
> kunmap_local(data_in);
>>>
> put_page(in_page);
>>>    					}
>>>    					in_page =3D
> find_get_page(mapping,
>>>
> start >> PAGE_SHIFT);
>>> -					data_in =3D kmap(in_page);
>>> +					mstack[sind] =3D 'B';
>>> +					sind++;
>>> +					data_in =3D
> kmap_local_page(in_page);
>>>    					memcpy(workspace->buf + i
> * PAGE_SIZE,
>>>    					       data_in,
> PAGE_SIZE);
>>>    					start +=3D PAGE_SIZE;
>>>    				}
>>>    				workspace->strm.next_in =3D
> workspace->buf;
>>>    			} else {
>>
>> I think we can clean up the code.
>>
>> In fact the for loop can handle both case, I didn't see any special
>> reason to do different handling, we can always use workspace->buf,
>> instead of manually dancing using different paths.
>>
> As I said in a recent email, I'm relatively new to kernel development,
> especially to Btrfs and other filesystems.

That's not a big deal, that's why we're here to provide help.

>
> However, I noted that this code does different handling depending on how
> many "in_page" is going to map. I am not able to say why...

AFAIK the reason is optimization.

The idea is like this, if there are multiple pages left as input, we
copy the pages from page cache into the workspace buffer.

If there is no more than one page left, we use that page from page cache
directly.

I believe that's the problem causing the difficult in converting to
kmap_local_page().

>
>>
>> I believe with all these cleanup, it should be much simpler to convert
>> to kmap_local_page().
>>
>> I'm pretty happy to provide help on this refactor if you don't feel
>> confident enough on this part of btrfs.
>>
>
> Thanks for any help you can provide, but let me be clear about what my g=
oal
> is. I've been assigned with the task to convert kmap() (and possibly als=
o
> kmap_atomic()) to kmap_local_page() wherever it can be done across the
> entire kernel.
>
> Furthermore, wherever it cannot be done with the API we already have,
> changes to the API will be required. One small change has already been
> carried out upon David's suggestion to make kunmap_local() to take point=
ers
> to const void. However I'm also talking of much larger changes, if they =
are
> needed.
>
> This is to say that I cannot spend too much on Btrfs. There is lot of wo=
rk
> to be done in other subsystems where I don't yet know which kinds of
> difficulties I'm going to find out.
>
> Any help with clean-ups / refactoring of zlib_compress_pages() will be m=
uch
> appreciated for the reasons I've tried to convey in the paragraphs above=
.

I'll send out a cleanup for zlib_compress_pages(), mostly to make the
(strm.avail_in =3D=3D 0) branch to call kmap() and kunmap() in pairs,
without holding @in_page mapped.

Would that make it easier?

Thanks,
Qu

>
> Thank you so much,
>
> Fabio
>
>> Thanks,
>> Qu
>>
>>> -				if (in_page) {
>>> -					kunmap(in_page);
>>> +				if (data_in) {
>>> +					sind--;
>>> +					kunmap_local(data_in);
>>>    					put_page(in_page);
>>>    				}
>>>    				in_page =3D find_get_page(mapping,
>>>    							start
>>> PAGE_SHIFT);
>>> -				data_in =3D kmap(in_page);
>>> +				mstack[sind] =3D 'B';
>>> +				sind++;
>>> +				data_in =3D kmap_local_page(in_page);
>>>    				start +=3D PAGE_SIZE;
>>>    				workspace->strm.next_in =3D data_in;
>>>    			}
>>> @@ -196,23 +206,39 @@ int zlib_compress_pages(struct list_head *ws,
> struct address_space *mapping,
>>>    		 * the stream end if required
>>>    		 */
>>>    		if (workspace->strm.avail_out =3D=3D 0) {
>>> +			sind--;
>>> +			kunmap_local(data_in);
>>> +			data_in =3D NULL;
>>> +
>>> +			sind--;
>>>    			kunmap_local(cpage_out);
>>>    			cpage_out =3D NULL;
>>> +
>>>    			if (nr_pages =3D=3D nr_dest_pages) {
>>>    				out_page =3D NULL;
>>> +				put_page(in_page);
>>>    				ret =3D -E2BIG;
>>>    				goto out;
>>>    			}
>>> +
>>>    			out_page =3D alloc_page(GFP_NOFS);
>>>    			if (out_page =3D=3D NULL) {
>>> +				put_page(in_page);
>>>    				ret =3D -ENOMEM;
>>>    				goto out;
>>>    			}
>>> +
>>> +			mstack[sind] =3D 'A';
>>> +			sind++;
>>>    			cpage_out =3D kmap_local_page(out_page);
>>>    			pages[nr_pages] =3D out_page;
>>>    			nr_pages++;
>>>    			workspace->strm.avail_out =3D PAGE_SIZE;
>>>    			workspace->strm.next_out =3D cpage_out;
>>> +
>>> +			mstack[sind] =3D 'B';
>>> +			sind++;
>>> +			data_in =3D kmap_local_page(in_page);
>>>    		}
>>>    		/* we're all done */
>>>    		if (workspace->strm.total_in >=3D len)
>>> @@ -235,10 +261,16 @@ int zlib_compress_pages(struct list_head *ws,
> struct address_space *mapping,
>>>    			goto out;
>>>    		} else if (workspace->strm.avail_out =3D=3D 0) {
>>>    			/* get another page for the stream end */
>>> +			sind--;
>>> +			kunmap_local(data_in);
>>> +			data_in =3D NULL;
>>> +
>>> +			sind--;
>>>    			kunmap_local(cpage_out);
>>>    			cpage_out =3D NULL;
>>>    			if (nr_pages =3D=3D nr_dest_pages) {
>>>    				out_page =3D NULL;
>>> +				put_page(in_page);
>>>    				ret =3D -E2BIG;
>>>    				goto out;
>>>    			}
>>> @@ -247,11 +279,18 @@ int zlib_compress_pages(struct list_head *ws,
> struct address_space *mapping,
>>>    				ret =3D -ENOMEM;
>>>    				goto out;
>>>    			}
>>> +
>>> +			mstack[sind] =3D 'A';
>>> +			sind++;
>>>    			cpage_out =3D kmap_local_page(out_page);
>>>    			pages[nr_pages] =3D out_page;
>>>    			nr_pages++;
>>>    			workspace->strm.avail_out =3D PAGE_SIZE;
>>>    			workspace->strm.next_out =3D cpage_out;
>>> +
>>> +			mstack[sind] =3D 'B';
>>> +			sind++;
>>> +			data_in =3D kmap_local_page(in_page);
>>>    		}
>>>    	}
>>>    	zlib_deflateEnd(&workspace->strm);
>>> @@ -266,13 +305,15 @@ int zlib_compress_pages(struct list_head *ws,
> struct address_space *mapping,
>>>    	*total_in =3D workspace->strm.total_in;
>>>    out:
>>>    	*out_pages =3D nr_pages;
>>> -	if (cpage_out)
>>> -		kunmap_local(cpage_out);
>>> -
>>> -	if (in_page) {
>>> -		kunmap(in_page);
>>> -		put_page(in_page);
>>> +	while (--sind >=3D 0) {
>>> +		if (mstack[sind] =3D=3D 'B') {
>>> +			kunmap_local(data_in);
>>> +			put_page(in_page);
>>> +		} else {
>>> +			kunmap_local(cpage_out);
>>> +		}
>>>    	}
>>> +
>>>    	return ret;
>>>    }
>>>
>>
>
>
>
>
