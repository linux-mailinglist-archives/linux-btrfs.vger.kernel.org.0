Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0CC571C86
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiGLO3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiGLO2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 10:28:49 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491C63FE
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 07:28:47 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id u20so7958585iob.8
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Up4BbXSp9c+G4VbFijIoI+dC54B6244+/tApAza2KM=;
        b=MZoNVjPV7cvTKJo8Ptq4Uc/0TbQ/2zP14xS07bGflHL3+uII5ahzuRFUB1D7BfXqPi
         HA15eiMreQCC36NT0ztEQ9NwDHadGRtRwdQr1LyYumnUj0A0giUq7Szn02oqkQ7IlrRp
         qVd35/5naCnrPMSgRFSWgw6/YUHWWH6tkGqtGhKHeJTRVMab0aKDXcK9/HNL/7RcWWcD
         18MBTFWzqujavjVo1g+kisWaK5CGqRI0ru+GaaBl06OwTIvLgIXJGhXlD47pfKQtkOzm
         afux13Myg7USHd38hcA3tu8HjamXfrl3LmXBjuYiQXQ0gxha5uQ02HRj7PyxBOgRJmQ0
         8tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Up4BbXSp9c+G4VbFijIoI+dC54B6244+/tApAza2KM=;
        b=AgHjJyngtTMRK7E8bIlAk6x8FGI+43I/Ik832NWE2SKB9RAieN9+prM0UssYkk6/AW
         EIdfjjTrQGYeDjKxJXOGgIHDh2ebGh5Ch2TNS2XG5iI4kbBKw9Ls5lFI0sZ+Y46W+Pto
         Mu4e80p7pydcQsg9VloYH+wXeHqW1sIigAiTVkKaNC5PKy5N+X3HmoX1J6E6njF8HymR
         PM4IVuEL4Unp7qVYNcMD5Piwni0LnD8VYlz0SiYbIV69KIT0K4bX9boR6h4JPRxd0wKW
         x7BIjxDoeYL07o2IfJrACdNoU/GOw9f4T/teXaDrJv9Rg+0UifW9/NccoHz0LrdTWdjH
         CluQ==
X-Gm-Message-State: AJIora9zuccLniDiZtBYVbxW31NGHm7fGMLyseRWRLX6PZ5EFUVZ4H0R
        hZOaRmb6U7dU2bbtaFAIRhNGISt+f8Ra+TIqXreOurjj
X-Google-Smtp-Source: AGRyM1shx2zU5JcDP+TIgSWC7uoEZguGVHqfh+MYRwlR5vQzTw1BhpCEw6/H/wcYqVyq9zk7sNskHBq3yRa6p9XAaIY=
X-Received: by 2002:a05:6602:1644:b0:678:8ba4:8df6 with SMTP id
 y4-20020a056602164400b006788ba48df6mr12250774iow.138.1657636126610; Tue, 12
 Jul 2022 07:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGSM=J8K7_GfaqL3-7obOSytNhtoqmJ1GQrOKAUgE2dF7OehTg@mail.gmail.com>
 <2ba98b68-f22b-5013-8c4b-47b5c62ed437@suse.com> <fbd58f24-02ba-3c84-0c05-4de5f44d779c@gmx.com>
 <097bd15e-9afb-7170-06d3-2fc365092ff1@suse.com> <eec791a1-f7f4-b897-3f76-b08418c148a4@gmx.com>
 <44836a39-9e27-6418-02f5-8e120f2ad642@suse.com>
In-Reply-To: <44836a39-9e27-6418-02f5-8e120f2ad642@suse.com>
From:   Peter Allebone <allebone@gmail.com>
Date:   Tue, 12 Jul 2022 10:28:30 -0400
Message-ID: <CAGSM=J9+hppBTVei+YpyiwOmV_p1QwEYp3bzkwJNLiLfmKQusQ@mail.gmail.com>
Subject: Re: BIG_METADATA - dont understand fix or implications
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok I understand. Thank you for your time and effort, and reply. Hope
you have a great day :)

Kind regards
Peter

On Tue, Jul 12, 2022 at 9:30 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 12.07.22 =D0=B3. 16:22 =D1=87., Qu Wenruo wrote:
> >
> >
> > On 2022/7/12 21:18, Nikolay Borisov wrote:
> >>
> >>
> >> On 12.07.22 =D0=B3. 16:13 =D1=87., Qu Wenruo wrote:
> >>>
> >>>
> >>> On 2022/7/12 21:05, Nikolay Borisov wrote:
> >>>>
> >>>>
> >>>> On 12.07.22 =D0=B3. 15:24 =D1=87., Peter Allebone wrote:
> >>>>> Hi there,
> >>>>>
> >>>>> Apologies in advance, I dont understand how I am affected by this
> >>>>> issue here:
> >>>>>
> >>>>> https://lore.kernel.org/linux-btrfs/20220623142641.GQ20633@twin.jik=
os.cz/
> >>>>>
> >>>>>
> >>>>>
> >>>>> I have a problem where if I run "sudo btrfs inspect-internal
> >>>>> dump-super /dev/sdbx" on some disks it  shows the BIG_METADATA flag
> >>>>> and some disks it does not. I posted about it here on reddit:
> >>>>>
> >>>>> https://www.reddit.com/r/btrfs/comments/vo8run/why_does_the_inspect=
internal_command_not_show_big/
> >>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> My concern is what effect does this have and how do I fix it, once =
the
> >>>>> patch makes its way down to me. Is there any concern with data on t=
hat
> >>>>> disk changing in an unexpected way?
> >>>>>
> >>>>> Many thanks for any insight you can shed. I did read the thread but
> >>>>> was not able to easily follow or understand what was implied or wha=
t
> >>>>> would happen to someone affected by the issue.
> >>>>>
> >>>>> Thank you again in advance. Sorry for emailing in. Hope that is ok.=
 I
> >>>>> was just concerned.
> >>>>
> >>>> If you are using recent kernels i.e stable ones then there are no
> >>>> practical implications, because as soon as you mount the filesystem
> >>>> with
> >>>> a kernel which has the patch this flag would be correctly set. As sa=
id
> >>>> in the changelog of the patch this can be a potential problem for
> >>>> pre-3.10 kernels (very old) so the conclusion is you have nothing to=
o
> >>>> worry about.
> >>>
> >>> I just went checking v3.9 and v3.5, if there is no such flag, kernel
> >>> will still mount the fs and setting the flag.
> >>>
> >>> So it doesn't seem to cause any compatibility problems at all.
> >>
> >> But that's the point, fs created post 3.10 should not be mountable by
> >> pre 3.10 because they'd see an unknown flag.
> >
> > Oh, got it now.
> >
> > Although the introduction of that flag is a little older, in v3.4. (v3.=
3
> > doesn't have it).
>
> Yes you are right, commit 727011e07cbd ("Btrfs: allow metadata blocks
> larger than the page size") landed in 3.4 not 3.10, so the changelog of
> the patch needs to be changed.
>
>
> >
> > Thanks,
> > Qu
> >>
> >>>
> >>> Thanks,
> >>> Qu
> >>>>
> >>>>>
> >>>>> Kind regards
> >>>>> Peter
