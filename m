Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42551A3D66
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 02:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgDJAch (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 20:32:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39331 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgDJAch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 20:32:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so473849wrt.6
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Apr 2020 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5tTm0L3KdzxyWoqLVTazhNGp0DQRo8lf5i45CSuMdo=;
        b=YZ4U6Oli5gBczZaePdG7WybldMKFINgChmHip9L1tQ0wsHj5Wjv6nrd7x1xk6pjitw
         PBCBl/XtXruNRoe/VR3P0qOT5s1wrAeyrnAm1mRZM2GX9VYa3McwtwpCtXxTPX8Xe2Ik
         mxp7W4vp+/VZ1tqpeKkLLRq6iCYdqnGPO3ULbmAq9jcH1Gduijtoky29JmzjB3K3wx6C
         N72v+7ciZG8p9h9sOPok/NlPvs4ErQcOTq6khFNFBkA7/OL01DjFIN10JFVlJayOPThU
         NSsFDaBmHhJn8SlNHJz+FvD7+nDO+ISOaaalz1vr/+bLClBclwhF4Guek/B/++PoHdz+
         /QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5tTm0L3KdzxyWoqLVTazhNGp0DQRo8lf5i45CSuMdo=;
        b=JLDGyBe2zFUfEEPSx1Mrf9XaHjTaMnvNqYvoXINYC4DvZ0yXTNGwCiKfvDXjuYFmRj
         iVJEN508XN8UEux/k40I3RLvDYHPlzLySpdJvzYA5zU9fKL421wox5xHYQ7sqKt7DBB+
         PxYOwhuqzS3OYHVt0DgklxFNP3udKj+4Ux6TXtjIaE8B8Bz2buHn+uS1iRIYJHO2NSiR
         cya9dcx7YyElJQAV4lC8cB+tE4jTb5NHsIWfwgd3oBqYvTBuyVyYF33f0x1cjHw5TTsg
         wGZw0fKLLKhzfOVw7QEpXHjeUewKB5SilZEutZxPA/63KonxAPNVpA6lyMICqSgj6Y61
         wcHw==
X-Gm-Message-State: AGi0Pub189JQMDqSJcYUVyqNciA6d5eIUKKjvGTa48yBe70qSw5vb1uy
        hDwQdwBHFYuglY7Cw+2QF1AO+mjAaSXZ/uh/59svZII4qbw=
X-Google-Smtp-Source: APiQypJzfmfZ5ivB5eBCfSETznqWSpNBRIxQ/xWJAXozenO79mbnH+dBo0cYYfTDqhfpbNfyF8465FkeMYS67GiRpJ8=
X-Received: by 2002:a5d:6148:: with SMTP id y8mr1753101wrt.236.1586478754527;
 Thu, 09 Apr 2020 17:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com>
 <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtSiSBQfonL-zVacZAOT7_Z1vNC0NKSiDvib+MoLv27DWA@mail.gmail.com>
In-Reply-To: <CAJCQCtSiSBQfonL-zVacZAOT7_Z1vNC0NKSiDvib+MoLv27DWA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 9 Apr 2020 18:32:18 -0600
Message-ID: <CAJCQCtSGCQ6j94XfN3CNCzq8AEzopqnd_YL4NaExe9W2-SY-sg@mail.gmail.com>
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

On Thu, Apr 9, 2020 at 6:31 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Thu, Apr 9, 2020 at 2:50 AM Johannes Thumshirn
> <Johannes.Thumshirn@wdc.com> wrote:
> >
> > On 09/04/2020 02:18, Chris Murphy wrote:
> > > On Wed, Apr 8, 2020 at 5:17 AM Johannes Thumshirn
> > > <Johannes.Thumshirn@wdc.com> wrote:
> > >>
> > >> On 07/04/2020 20:02, Chris Murphy wrote:
> > >>> Hi,
> > >>>
> > >>> What's the status of this work?
> > >>> https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@suse.de/
> > >>
> > >> It's done but no-one was interested in it and as I haven't received any
> > >> answers from Dave if he's going to merge it, I did not bring it to
> > >> attention again. After all it was for a specific use-case SUSE has/had
> > >> and I left the company.
> > >
> > > I'm thinking of a way to verify that a non-encrypted generic
> > > boot+startup data hasn't been tampered with. That is, a generic,
> > > possibly read-only boot, can be authenticated on the fly. Basically,
> > > it's fs-verity for Btrfs, correct?
> > >
> >
> > Correct, example deployments would be embedded devices, or container
> > images. I've written a paper [1] for the 2019 SUSE Labs Conference
> > describing some of the scenarios, if you're interested.
>
> "downside to this is, on every unmount, the new hash value needs to be
> stored safely" [in e.g. a TPM]
>
> Could this make the file system not crash safe? As in, would you use
> authenticated btrfs in a read-only context, like seed-device? Or some
> industrial application where you're very, very certain, that the use
> case never calls for unplanned power failure or forced power off by a
> user? Seems difficult to use it in a desktop or laptop use case.

Nevermind... :D

\subsubsection{HMAC}

I'm just gonna read the whole thing.


-- 
Chris Murphy
