Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99114F7E8
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 14:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgBANH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 08:07:28 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44485 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBANH2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Feb 2020 08:07:28 -0500
Received: by mail-il1-f195.google.com with SMTP id s85so5251039ill.11;
        Sat, 01 Feb 2020 05:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oNKC7fDBF5bypMMsY3mRJy+utUKLGrjciGC3lDrgQ1s=;
        b=SXEBA+tPeh6jGa9IdMJaUREtXKGtqqX9CLtkw/+Xfre+LMAJrwxyLt33mpm1ZiqgJQ
         QM5UdOvS3oNu9u8VujN0ZOazlwi0a4+qw2FwnlnHWFc3t7WSz+m92hBjqzF68ourdDWY
         tnPb0gYe5m1FNoGAGcVN2zzl3P2egB8CtZkkQNJeVgXYO3aoFjRnyPbOwG6CjE8GNyqL
         0ZwRECThXoQA+HMzVEpSk8VMGZVMGbZgAc9ZleddcJLq1lUFivHPloyDoLqBx/hWcREE
         +g2sR8K8y2U/Hi7TZhkp+9kARkpjMilghf7Fqq7vS6yNEGPF8YV73koJ+7L/5iQRnRVR
         Jqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oNKC7fDBF5bypMMsY3mRJy+utUKLGrjciGC3lDrgQ1s=;
        b=uG/M9N6BNY+p6vg7A01t3M26Drqoxl+b+QOvI51K789mhK86yjZ3CqVgT0/8YiPVR1
         hUs0Foe38PqP5xhghyllYIjqggCk1Be+QywVKGbXJMV2m91vgeVBDOsu6vsbOkImJgJG
         7Q66LXJE1bYdfYpibQG6cxL3cUnbn9C0E1E8lwO4JKaSnDmq5nT4G2enLat4zvygseDL
         jAZO5sG0JPJiqjw4rXYbbjRHMjrD0DmLJcmc/QviPQOXjPv/+xWN3eYPojPdKzh7rY55
         mOdX3PHyWVjrOLo1/xlqB0o2uVbDzj6no9xSKtAu8+fEugk0j0UM+jspXhvMdgJ77nqg
         tnSw==
X-Gm-Message-State: APjAAAXw4jZsSkzBo1+Q+erL1FHRi3Z7fIjmUHfndscIhpRYmPu1If3L
        KOTzVVpUpZXwZfNRjbrv1FELbD3Btiqzz/spf3s=
X-Google-Smtp-Source: APXvYqx3+Gx+gIejbyuzt6sWJ6pulqhDnZM9iFTZSZMn3Nl3GqjRKOQC3qXXSpmALrzdMnhA1342lzXegvRL7mBJe2o=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr7139367ilq.250.1580562447510;
 Sat, 01 Feb 2020 05:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20200114125044.21594-1-wqu@suse.com> <20200201073649.GA2697@desktop>
 <CAOQ4uxj_MFHrWthckSVUaHp3us2eNFeZRc_wuD90CxcUveYUTA@mail.gmail.com> <c3310387-da7b-3184-147f-67f00eed1aae@suse.com>
In-Reply-To: <c3310387-da7b-3184-147f-67f00eed1aae@suse.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Feb 2020 15:07:16 +0200
Message-ID: <CAOQ4uxiu6T-cHr5TZ93K1U5fGnu8bG4RSpkZqMvvDEw_wDCuPg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/153: Remove it from auto group
To:     Qu Wenruo <wqu@suse.com>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 1, 2020 at 2:39 PM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2020/2/1 =E4=B8=8B=E5=8D=887:10, Amir Goldstein wrote:
> > On Sat, Feb 1, 2020 at 9:41 AM Eryu Guan <guaneryu@gmail.com> wrote:
> >>
> >> On Tue, Jan 14, 2020 at 08:50:44PM +0800, Qu Wenruo wrote:
> >>> This test case always fail after commit c6887cd11149 ("Btrfs: don't d=
o
> >>> nocow check unless we have to").
> >>> As btrfs no longer checks nodatacow at buffered write time.
> >>>
> >>> That commits brings in a big performance enhancement, as that check i=
s
> >>> not cheap, but breaks qgroup, as write into preallocated space now ne=
eds
> >>> extra space.
> >>>
> >>> There isn't yet a good solution (reverting that patch is not possible=
,
> >>> and only check nodatacow for quota enabled case is very bug prune due=
 to
> >>> quite a lot code change).
> >>>
> >>> We may solve it using the new ticketed space reservation facility, bu=
t
> >>> that won't come into fruit anytime soon.
> >>>
> >>> So let's just remove that test case from 'auto' group, but still keep
> >>> the test case to inform we still have a lot of work to do.
> >>>
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>
> >> I'd like to see an ACK from btrfs folks. Thanks!
> >>
> >> Eryu
> >>
> >>> ---
> >>>  tests/btrfs/group | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tests/btrfs/group b/tests/btrfs/group
> >>> index 697b6a38ea00..3c554a194742 100644
> >>> --- a/tests/btrfs/group
> >>> +++ b/tests/btrfs/group
> >>> @@ -155,7 +155,7 @@
> >>>  150 auto quick dangerous
> >>>  151 auto quick volume
> >>>  152 auto quick metadata qgroup send
> >>> -153 auto quick qgroup limit
> >>> +153 quick qgroup limit
> >
> > Hmm, if removing from auto it might make sense to also remove it
> > from quick, because people often use quick as a sanity regression group=
.
>
> That's also one of my concern.
>
> However recently I tend to run more same VMs on different ranges of
> fstests to speed up the testing progress other than using 'quick' group.
>
> Anyway this depends on the end users (QA and developers).
>
> >
> > The issue at hand is a recurring pattern.
> > It is also been discussed recently about generic/484:
> > https://lore.kernel.org/fstests/20200131164619.GA13005@infradead.org/
> >
> > I also handled something like this with:
> > fdb69864 overlay/061: remove from auto and quick groups
> >
> > I suggest adding a group 'broken' to mark known/wontfix issues
> > then a default regression test could run -g auto -x broken
> > or -g quick -x broken for a quick regression sanity.
>
> That's much better.
>
> Just one question, if a test is in both quick and broken group, will -g
> quick -x broken still exclude it?
>

Yes.
That is the main use case for -x. Often used with -x dangerous.

What we don't have, AFAIK, is the ability to request 'auto && quick'.

Thanks,
Amir.
