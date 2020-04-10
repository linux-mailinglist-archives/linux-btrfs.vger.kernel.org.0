Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2771A3DCA
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 03:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJBfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 21:35:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46895 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJBfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 21:35:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id f13so591276wrm.13
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Apr 2020 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OWrGajWxtXcdiauj3eRB2E9v2o5Ilj13ODsYerCXbo=;
        b=ZsN7N9QweTPtTr2eiIRh3LDcQzOui0a9fDsLzvZtSST0ObYXwJlcCZCRytsP2gvMaD
         yTE0H8N/Bmj3RRHUSsiGGsjwidOrOpq4oDrsEg8t/dWVSHWDEYG/+BUmGHMAL9MoYJMm
         P5vWTklb7qHIdCCHC5lV/eOJGiy7lC4LN2CzF/FnKAd0bqbJAeAvTN10+eVW5627pnyc
         O09xzHV8xbvqB3MbpfG5ZorVPe34FAEU5RYP7lYI9AxWZVRlZnAy/jjatFgGRG5cGzXd
         kwPzWjAOcB0j9Cdi5aMg9x4oas6PL8gGaXGJtz8rXFwfJIiyhtQzgNwsXBsHfxwvWU7/
         ymxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OWrGajWxtXcdiauj3eRB2E9v2o5Ilj13ODsYerCXbo=;
        b=Q8hAtfl0fklolrpQ8UyHu7CQd/iTVfQQM4NrluLHS3p17ukuLEhE6wUBacxKQIAHtT
         oAm/4fTt1SwPf7TT69TpupIMvYXg0MJoOh2gM2WnR+30YVR20Gi9PKuMUjEPUroUndj4
         fm7zHkb6eOZLYMu+2k8f7wa2scrXlmrxessvRBoCi1hqs6K81zgvkb+y6ZhQTqnJRd6C
         FqAr8UeAuK9pMA6Kyz5wfHQAF4991uXbwkwITg53QX3LTnmyctK9O+TnhvG7yfe92+sg
         2XKydZ9Jb39zAN1ZNkXGEFJj2H69DfM4278tDGBmEb6L4YR55gBATsP+wuhNBeqAVV7A
         fiFA==
X-Gm-Message-State: AGi0PubU7e1GGyw28Z5dI/irb+KRds//V3x1UJhYcOtG1UjMkZuiuChj
        /2I7JLn1bByQYS2wbAJI05E4qBgjjg7D7xkl9TT8nA==
X-Google-Smtp-Source: APiQypLU5UyK8ErcxtTdjvy7y95K3Ge/Shhjby8EORi1wW4scZ786gGOpQU13Je3P0I3Dun0ucg+JoUT26Yzk4Sk7os=
X-Received: by 2002:a5d:6148:: with SMTP id y8mr1965184wrt.236.1586482538181;
 Thu, 09 Apr 2020 18:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com>
 <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtSiSBQfonL-zVacZAOT7_Z1vNC0NKSiDvib+MoLv27DWA@mail.gmail.com> <CAJCQCtSGCQ6j94XfN3CNCzq8AEzopqnd_YL4NaExe9W2-SY-sg@mail.gmail.com>
In-Reply-To: <CAJCQCtSGCQ6j94XfN3CNCzq8AEzopqnd_YL4NaExe9W2-SY-sg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 9 Apr 2020 19:35:21 -0600
Message-ID: <CAJCQCtQOTk_B=J2V85eqMioyec9zNLOD_jvq_9TKtAg_4K3ufQ@mail.gmail.com>
Subject: Re: authenticated file systems using HMAC(SHA256)
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 9, 2020 at 6:32 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Thu, Apr 9, 2020 at 6:31 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Thu, Apr 9, 2020 at 2:50 AM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > >
> > > On 09/04/2020 02:18, Chris Murphy wrote:
> > > > On Wed, Apr 8, 2020 at 5:17 AM Johannes Thumshirn
> > > > <Johannes.Thumshirn@wdc.com> wrote:
> > > >>
> > > >> On 07/04/2020 20:02, Chris Murphy wrote:
> > > >>> Hi,
> > > >>>
> > > >>> What's the status of this work?
> > > >>> https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@suse.de/
> > > >>
> > > >> It's done but no-one was interested in it and as I haven't received any
> > > >> answers from Dave if he's going to merge it, I did not bring it to
> > > >> attention again. After all it was for a specific use-case SUSE has/had
> > > >> and I left the company.
> > > >
> > > > I'm thinking of a way to verify that a non-encrypted generic
> > > > boot+startup data hasn't been tampered with. That is, a generic,
> > > > possibly read-only boot, can be authenticated on the fly. Basically,
> > > > it's fs-verity for Btrfs, correct?
> > > >
> > >
> > > Correct, example deployments would be embedded devices, or container
> > > images. I've written a paper [1] for the 2019 SUSE Labs Conference
> > > describing some of the scenarios, if you're interested.
> >
> > "downside to this is, on every unmount, the new hash value needs to be
> > stored safely" [in e.g. a TPM]
> >
> > Could this make the file system not crash safe? As in, would you use
> > authenticated btrfs in a read-only context, like seed-device? Or some
> > industrial application where you're very, very certain, that the use
> > case never calls for unplanned power failure or forced power off by a
> > user? Seems difficult to use it in a desktop or laptop use case.
>
> Nevermind... :D
>
> \subsubsection{HMAC}
>
> I'm just gonna read the whole thing.


"the used key has to be deployed at File System creation time and
cannot easily be modified afterwards"

Could a new HMAC be defined when adding a rw sprout device to a seed?
i.e. in this case you'd need two HMACs, until the seed device is
removed. Hmmm, maybe difficult. I don't think data checksums are
recomputed on seed being removed; the balance replicated metadata
block groups fairly intact including the csum tree.

Regarding the key being stored in the TPM. I know the Windows 10
hardware requirements say a TPM 2.0 must be present and enabled. But I
don't know to what degree such hardware is prevalent and supported by
the kernel.


-- 
Chris Murphy
