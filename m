Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5371A3D64
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 02:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgDJAbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 20:31:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52462 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgDJAbW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Apr 2020 20:31:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id t203so856132wmt.2
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Apr 2020 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnsN4+wNv9Z1zPNTZOeJnd0oOjpSi2TMmx4p60TwoAk=;
        b=cw8WNIclwY+2G6ntJ809B/LH5RkBrbcQaO6U2MOEhxiRn1+1dm62LIxwNCyi3a0ZZl
         HrfTVPRI/Fy325GD6SEOsqxPNYdnoaLTo8Lnv8wDUUgySNxWWVL4ILA3stsa6WS3yrNi
         gMcQkE7NLAm+jNzlRhswbqRKG/ejZEgNIYpWnwInFQzgM0Q4JQAgaUKr7aSy3pybOxvb
         HfTAnXwPwX04rikiJvqNifG9UrQcgD9ZUgj9IH0zQDclVFfHhBZWFpDHDPnHE41+c3IH
         6mdS9TQWmbrPjsLjwk97Egko97fyayGXsSHwCvLWdWKjH3c9DPoM8US5W3MD7nJ636tJ
         W7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnsN4+wNv9Z1zPNTZOeJnd0oOjpSi2TMmx4p60TwoAk=;
        b=cj3eDIO+F9fDNa8KOGO2vVc9FxRce2qwjwAquhqSqKgRK0FfhChWIZLsBfHx+f5CG8
         lmECfUzA5sYklbobUQ6xgGkOOqEDBUhGvPe6/WgGm99TSfUeeQXT1TMWRsLVFxdj8OtE
         K6nGmKlqMrGQ0ds2LImMY4KhYbnuSa9MY30dOIi9ePB3GtqPul4Ef9WyTfKO8Ad1wI2S
         1vqgcww58bu2v4R1yKrfElW4F/BV3ZiBPzLRq9JWjnFbUNttsxGVCtTCPOS631lzFI5/
         rYk3fBdCmc9ZgwkdTMxcgautfw6UwgOa8L8GPjOClxodnE3MxlYUEQaSLGX1KND77MGX
         KNjA==
X-Gm-Message-State: AGi0PuaFReX5zVl5nx1HzeEKlom9vDsAA0T1rIgUctG3LklEwm1csduX
        5kHi+XCMIpPdbUt/k85nQ8sxAkDrht7mc9ny961iHQ==
X-Google-Smtp-Source: APiQypL8Kbml7snLGbwn2feP4nfO1MYOOu0jcHFAZ+t+tL/IiiHIuTgCrOaoSdGXCR/3lw9qEAkGXZ6I7uHl/+pVx5o=
X-Received: by 2002:a05:600c:2645:: with SMTP id 5mr2358589wmy.168.1586478679798;
 Thu, 09 Apr 2020 17:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
 <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com> <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 9 Apr 2020 18:31:03 -0600
Message-ID: <CAJCQCtSiSBQfonL-zVacZAOT7_Z1vNC0NKSiDvib+MoLv27DWA@mail.gmail.com>
Subject: Re: authenticated file systems using HMAC(SHA256)
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 9, 2020 at 2:50 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 09/04/2020 02:18, Chris Murphy wrote:
> > On Wed, Apr 8, 2020 at 5:17 AM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 07/04/2020 20:02, Chris Murphy wrote:
> >>> Hi,
> >>>
> >>> What's the status of this work?
> >>> https://lore.kernel.org/linux-btrfs/20191015121405.19066-1-jthumshirn@suse.de/
> >>
> >> It's done but no-one was interested in it and as I haven't received any
> >> answers from Dave if he's going to merge it, I did not bring it to
> >> attention again. After all it was for a specific use-case SUSE has/had
> >> and I left the company.
> >
> > I'm thinking of a way to verify that a non-encrypted generic
> > boot+startup data hasn't been tampered with. That is, a generic,
> > possibly read-only boot, can be authenticated on the fly. Basically,
> > it's fs-verity for Btrfs, correct?
> >
>
> Correct, example deployments would be embedded devices, or container
> images. I've written a paper [1] for the 2019 SUSE Labs Conference
> describing some of the scenarios, if you're interested.

"downside to this is, on every unmount, the new hash value needs to be
stored safely" [in e.g. a TPM]

Could this make the file system not crash safe? As in, would you use
authenticated btrfs in a read-only context, like seed-device? Or some
industrial application where you're very, very certain, that the use
case never calls for unplanned power failure or forced power off by a
user? Seems difficult to use it in a desktop or laptop use case.


-- 
Chris Murphy
