Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E444A6536
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Feb 2022 20:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiBAT43 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Feb 2022 14:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiBAT42 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Feb 2022 14:56:28 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84390C061714
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Feb 2022 11:56:28 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id r65so54181910ybc.11
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Feb 2022 11:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aWiZo1WF3YLkn60/W/E5kAzeaW7gH8TmBkIpFCsfs7A=;
        b=SnqbkjuzXcDGXcHRffS1tb/1ZMnux6usaE+TTNoBvXEHEpj+CqyXbXEq1nRYSewsVQ
         XU/1BNxvMHDXPgl6L7bQy/rsga5upjPT4eyPTZ21eG5p49G6lLxhR5ZnG/9ApVtv4vqv
         wwItf2+mqLwYiMOm9Y8TEk14HOLeUfAu/0XLYK10Z2FHdr7ku72D1Hn1kzYkZaQoh6Ov
         FEsHXwbJUF9L0/uIl2ILgkOYAJDc4yRXWARy3q7/Mmkn6Arjd4KvSSouzJbYYtfvmdr4
         8SvdkiyKtXIN7LYqc/DocZW98evnORWfZvtg52jltmj7EqCmfGyyhx9pj4SeD+coUPrT
         roHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aWiZo1WF3YLkn60/W/E5kAzeaW7gH8TmBkIpFCsfs7A=;
        b=3EB3nRmGa5crrvgYdNzSUFpfAz5O/aqofu3cuqoU93YmExV7/KRbkB/JmYbO+lwJAn
         31MkS8VbpxxJ6ijjCMpxqEZ+wuS6E2oIWR0NwapYoaSpMW1TMQ1FFSTCwxByja9Ikd/v
         9SxhSaLXsn9vWYUl0BUSZDgYRQz10CbelXPK1VW/kIkuwu3aRujUX0xrNLrvpW8KVycI
         9jv57pGJ+N2N0vdYNZWEgbYTfZczWBE9A8xsTSYQnsyFxRfTrLa1tCdJr++V9Ih2fSE/
         PvSAgrPmc+GIwZc0bEdXmRJiYoRXEnwCU0kW8AvyRAoxRnGyeztpn1kqsjFRTVBFss5/
         QmUQ==
X-Gm-Message-State: AOAM532YN4kMQ1zGPnBovaJXbwMQf+5FWqgxEU6i6LO37l8QQx/f3T7L
        vj4Y6LrNMreVIg5czx/NclQoQC415tTsJvjPV60=
X-Google-Smtp-Source: ABdhPJyxbr+1ttBswEOAG+a58nW81HOl+dfnW84XvAlG5s+uVu+FNlEzXQg37wAaATkydsdmkkC3oL5Ttynhk+jJdAg=
X-Received: by 2002:a25:2388:: with SMTP id j130mr37698449ybj.513.1643745387676;
 Tue, 01 Feb 2022 11:56:27 -0800 (PST)
MIME-Version: 1.0
References: <9bdd0eb6-4a4f-e168-0fb0-77f4d753ec19@gmail.com>
 <YfHCLhpkS+t8a8CG@zen> <4263e65e-f585-e7f6-b1aa-04885c0ed662@gmail.com>
 <YfHXFfHMeqx4MowJ@zen> <CAJCQCtR5ngU8oF6apChzBgFgX1W-9CVcF9kjvgStbkcAq_TsHQ@mail.gmail.com>
 <042e75ab-ded2-009a-d9fc-95887c26d4d2@libero.it> <CAJCQCtQv327wHwsT+j+mq3Fvt2fJwyC7SqFcj_+Ph80OuLKTAw@mail.gmail.com>
 <295c62ca-1864-270f-c1b1-3e5cb8fc58dd@inwind.it> <367f0891-f286-198b-617c-279dc61a2c3b@colin.guthr.ie>
In-Reply-To: <367f0891-f286-198b-617c-279dc61a2c3b@colin.guthr.ie>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 1 Feb 2022 14:55:51 -0500
Message-ID: <CAEg-Je9rr4Y7JQbD3iO1UqMy48j7feAXFFeaqpJc6eP7FSduEw@mail.gmail.com>
Subject: Re: No space left errors on shutdown with systemd-homed /home dir
To:     Colin Guthrie <colin@booksterhq.com>
Cc:     kreijack@inwind.it, Chris Murphy <lists@colorremedies.com>,
        Boris Burkov <boris@bur.io>,
        "Apostolos B." <barz621@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        systemd Mailing List <systemd-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 1, 2022 at 2:02 PM Colin Guthrie <colin@booksterhq.com> wrote:
>
> Goffredo Baroncelli wrote on 30/01/2022 09:27:
> > On 29/01/2022 19.01, Chris Murphy wrote:
> >> On Sat, Jan 29, 2022 at 2:53 AM Goffredo Baroncelli
> >> <kreijack@libero.it> wrote:
> >>>
> >>> I think that for the systemd uses cases (singled device FS), a simple=
r
> >>> approach would be:
> >>>
> >>>       fstatfs(fd, &sfs)
> >>>       needed =3D sfs.f_blocks - sfs.f_bavail;
> >>>       needed *=3D sfs.f_bsize
> >>>
> >>>       needed =3D roundup_64(needed, 3*(1024*1024*1024))
> >>>
> >>> Comparing the original systemd-homed code, I made the following chang=
es
> >>> - 1) f_bfree is replaced by f_bavail (which seem to be more
> >>> consistent to the disk usage; to me it seems to consider also the
> >>> metadata chunk allocation)
> >>> - 2) the needing value is rounded up of 3GB in order to consider a
> >>> further 1 data chunk and 2 metadata chunk (DUP))
> >>>
> >>> Comments ?
> >>
> >> I'm still wondering if such a significant shrink is even indicated, in
> >> lieu of trim. Isn't it sufficient to just trim on logout, thus
> >> returning unused blocks to the underlying filesystem?
> >
> > I agree with you. In Fedora 35, and the default is ext4+luks+trim
> > which provides the same results. However I remember that in the past th=
e
> > default
> > was btrfs+luks+shrunk. I think that something is changed i.
> >
> > However, I want to provide do the systemd folks a suggestion ho change
> > the code.
> > Even a warning like: "it doesn't work that because this, please drop it=
"
> > would be sufficient.
>
>
> Out of curiosity (see other thread on the systemd list about this), what
> it the current recommendation (by systemd/btrfs folks rather then Fedora
> defaults) for homed machine partitioning?
>

I'd probably recommend Btrfs with the /home subvolume set with
nodatacow if you're going to use loops of LUKS backed Btrfs homedir
images. The individual Btrfs loops will have their own COW anyway.

Otherwise, the Fedora defaults for Btrfs should be sufficient.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
