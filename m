Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14753361622
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 01:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhDOX0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 19:26:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:44763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236674AbhDOX0C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 19:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618529135;
        bh=GdCH1djGJFL4LSi+Q14K+fBZ3DV6kan3W4jIXFIfF+s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LrYqOc6z+m6uCfkySstpMV1XoAMEnvkl82Hfdm4rv9PQ+vnqFQaCD4m3FFoGhoZZZ
         bY+qfwf3hOBD54LzXZcK+LEG66ajWoUNQsA95PxeZ0X9QQVa59z86s+fhfdTMjwsoy
         g6bZQoDAqf0l5Fpsc4y1CDSWOxo3mCZh0YRWQ1QM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgesQ-1m0kxH0Loi-00hABu; Fri, 16
 Apr 2021 01:25:35 +0200
Subject: Re: [PATCH 02/42] btrfs: introduce write_one_subpage_eb() function
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210415050448.267306-1-wqu@suse.com>
 <20210415050448.267306-3-wqu@suse.com>
 <7cff2211-b74a-647e-12f5-fb5994d9f3f0@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a442f0df-d4d7-50ca-e4c3-224200ef9a70@gmx.com>
Date:   Fri, 16 Apr 2021 07:25:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <7cff2211-b74a-647e-12f5-fb5994d9f3f0@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uRJVd9FIweO7NhZEAOyPjoNEvxmONcCKDOvMjQZki/u/mrE+lzo
 7+BsPmiwAWAA+Kywc5kT624ERXMrNp61uMMZ1COO24P/ZgQruFTdaAj+D5Ss51KfSc/P0C2
 O2oK5SOjfyJK3fAg8LGFT9vTwTTIfWWM2FAWHT9NDnpJuI8GoB2EIzZVFZP0j4Yh/AqMcMQ
 NulgsTHqvIuPN5xrmSjaA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQAi/X4zoWA=:KMks1MN/TYAtUuMX0hsLH8
 wblNUrPceua/DqRvMNRDn7twoMCyozBxfOzj/XtOo73cTlCsDjoavww6HbQRCkiMY/2B5wzRj
 kkjlhtGGXKWiJJDTsZHfb9AoJX1jTcUl3at5okmHlk7OlEOlRGObzTB0eyvQ3P5ytT/QAfDYj
 87GxmyovUSS4B/k+euqEDRJO/VdSDVKnhy6D6r13xHwOLrihrl8hbohH54Jh3tC/pKrS6wIiW
 2Qc6plh7Xt8b04Hk4YKIoL9SG5jzAObVQ/V9BhCcH/xlXwYagPqYOwGME+IJAFbT/KwFXEoKB
 8Vb9uKrVqxamWsa3VsKi47otgJC2SI+Z8mlya1rW/1PJTFQZ0gjli8D+cc6wOBBpRMo6xfU+I
 x4eVUqa2cpQSIMJn7rp3ePzWsZjai3py0oRqdcPpUa5GHichFlMCz2kjF4nU9mjw3BDkYbpSc
 rXK+VvbEvQyynpfwzJC3q9oTy8r3sDoK1Z74pcRrrAT9IAzs+4mGU352D2atCZkEoP4Yfnr2V
 LbO+XEcffUUl0DfQnIK7kRIg//+ryIhlqkFJzE9vvQqrmPFXHSagdE+tUnkEkGRP2btYkDV7H
 vY90ZaumzVoHC/Twvsj8ZimRl8MA1muFLqdMFymdCrA938YM3HgbWUEsRCrWOVqYI0Ymp5jlj
 HpDcM7ca31zaJh3dScxC+d8B7UhjQr6BdPZgkWGGESXBu7I0kb7CfbeXAnCiwYYDXFkxidd9G
 OlEh4eUssFCf2Ckff/Rfm08Nt4JKb3cBuc3KQbTr1CkpxEEjud3wkviOW0TC2IXaITK78dPWr
 jJWXTLOKgBMh9TBVUtswBToIkstyaBapJb4suRVMgnEszBkD4cZILgFofgY8nHabUtFXohVaM
 uYAERZugqhVQ4piEtH3LTYR5hjnn6uJVspRBgRWF4ca34UUD+ekUxyIKIgHylydHDp4sD6ior
 fhxPOcp7C/zaT8tHYdbvYyvbezQRCqhP4dC4W027C3A9A+zI5p5NftA0nI1o5wDwzcHt42jny
 +wLHZ96++DPNhSOiPgqHIEahq35LWWRwQ6k5uMv8F9QRzMK5AgQI7c4uS+6s2DT4An6Ecv27P
 XiLxbOeAOG1/fkcS4kB9V960o1Qw8DGsGrUT0iGnYB9zox1EynWPowtD0/6YY6R/N44+PiLSE
 b0LkpfON+GuB9P6EahJkA4gLLf2VsDiqIe5kz7jfT09HrrALmF/D9JY26CWeARtuc3kisxaEU
 z+tCt2Q8h4uIPxv5T
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/16 =E4=B8=8A=E5=8D=883:03, Josef Bacik wrote:
> On 4/15/21 1:04 AM, Qu Wenruo wrote:
>> The new function, write_one_subpage_eb(), as a subroutine for subpage
>> metadata write, will handle the extent buffer bio submission.
>>
>> The major differences between the new write_one_subpage_eb() and
>> write_one_eb() is:
>> - No page locking
>> =C2=A0=C2=A0 When entering write_one_subpage_eb() the page is no longer=
 locked.
>> =C2=A0=C2=A0 We only lock the page for its status update, and unlock im=
mediately.
>> =C2=A0=C2=A0 Now we completely rely on extent io tree locking.
>>
>> - Extra bitmap update along with page status update
>> =C2=A0=C2=A0 Now page dirty and writeback is controlled by
>> =C2=A0=C2=A0 btrfs_subpage::dirty_bitmap and btrfs_subpage::writeback_b=
itmap.
>> =C2=A0=C2=A0 They both follow the schema that any sector is dirty/write=
back, then
>> =C2=A0=C2=A0 the full page get dirty/writeback.
>>
>> - When to update the nr_written number
>> =C2=A0=C2=A0 Now we take a short cut, if we have cleared the last dirty=
 bit of the
>> =C2=A0=C2=A0 page, we update nr_written.
>> =C2=A0=C2=A0 This is not completely perfect, but should emulate the old=
 behavior
>> =C2=A0=C2=A0 good enough.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++++++++=
++++++
>> =C2=A0 1 file changed, 55 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 21a14b1cb065..f32163a465ec 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4196,6 +4196,58 @@ static void
>> end_bio_extent_buffer_writepage(struct bio *bio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_put(bio);
>> =C2=A0 }
>> +/*
>> + * Unlike the work in write_one_eb(), we rely completely on extent
>> locking.
>> + * Page locking is only utizlied at minimal to keep the VM code happy.
>> + *
>> + * Caller should still call write_one_eb() other than this function
>> directly.
>> + * As write_one_eb() has extra prepration before submitting the
>> extent buffer.
>> + */
>> +static int write_one_subpage_eb(struct extent_buffer *eb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct writeback_control *wbc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct extent_page_data *epd)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct btrfs_fs_info *fs_info =3D eb->fs_info;
>> +=C2=A0=C2=A0=C2=A0 struct page *page =3D eb->pages[0];
>> +=C2=A0=C2=A0=C2=A0 unsigned int write_flags =3D wbc_to_write_flags(wbc=
) | REQ_META;
>> +=C2=A0=C2=A0=C2=A0 bool no_dirty_ebs =3D false;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* clear_page_dirty_for_io() in subpage helper need=
 page locked. */
>> +=C2=A0=C2=A0=C2=A0 lock_page(page);
>> +=C2=A0=C2=A0=C2=A0 btrfs_subpage_set_writeback(fs_info, page, eb->star=
t, eb->len);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* If we're the last dirty bit to update nr_written=
 */
>> +=C2=A0=C2=A0=C2=A0 no_dirty_ebs =3D btrfs_subpage_clear_and_test_dirty=
(fs_info, page,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->start, eb->len);
>> +=C2=A0=C2=A0=C2=A0 if (no_dirty_ebs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clear_page_dirty_for_io(pag=
e);
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D submit_extent_page(REQ_OP_WRITE | write_fla=
gs, wbc, page,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb-=
>start, eb->len, eb->start - page_offset(page),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ep=
d->bio, end_bio_extent_buffer_writepage, 0, 0, 0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fal=
se);
>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_subpage_clear_writeba=
ck(fs_info, page, eb->start,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 eb->len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_btree_ioerr(page, eb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_page(page);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_dec_and_test(&eb=
->io_pages))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end=
_extent_buffer_writeback(eb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 unlock_page(page);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Submission finishes without problem, if no =
range of the page is
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * dirty anymore, we have submitted a page.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Update the nr_written in wbc.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (no_dirty_ebs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_nr_written(wbc, 1);
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0 static noinline_for_stack int write_one_eb(struct extent_buffer =
*eb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct writeback_control *wbc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct extent_page_data *epd)
>> @@ -4227,6 +4279,9 @@ static noinline_for_stack int
>> write_one_eb(struct extent_buffer *eb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memzero_extent_b=
uffer(eb, start, end - start);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (eb->fs_info->sectorsize < PAGE_SIZE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return write_one_subpage_eb=
(eb, wbc, epd);
>> +
>
> Same comment here, again you're calling write_one_eb() which expects to
> do the eb thing, but then later have an entirely different path for the
> subpage stuff, and thus could just call your write_one_subpage_eb()
> helper from there instead of stuffing it into write_one_eb().

But there are some common code before calling the subpage routine.

I don't think it's a good idea to have duplicated code between subpage
and regular routine.

>
> Also, I generally don't care about ordering of patches as long as they
> make sense generally.
>
> However in this case if you were to bisect to just this patch you would
> be completely screwed, as the normal write path would just fail to write
> the other eb's on the page.=C2=A0 You really need to have the patches th=
at do
> the write_cache_pages part done first, and then have this patch.

No way one can bisect to this patch.
Without the last patch to enable subpage write, bisect will never point
to this one.

And how could it be possible to implement data write before metadata?
Without metadata write ability, data write won't even be possible.

But without data write ability, metadata write can still be possible,
just doing basic touch/inode creation or even inline extent creation.

So I'm afraid metadata write patches must be before data write patches.

Thanks,
Qu

>
> Or alternatively, leave the order as it is, and simply don't wire the
> helper up until you implement the subpage writepages further down.=C2=A0=
 That
> may be better, you won't have to re-order anything and you can maintain
> these smaller chunks for review, which may not be possible if you
> re-order them.=C2=A0 Thanks,
>
> Josef
