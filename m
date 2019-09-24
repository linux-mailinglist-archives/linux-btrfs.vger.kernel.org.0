Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09FBC8C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505044AbfIXNVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 09:21:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33902 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505041AbfIXNVX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 09:21:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so1720393qke.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OTsuLTZ/FRMZyfy0BZfU4pYmxBxgwTorMU5kJlW3azw=;
        b=U6K+xYGy4MU0zYmUKhVbNdiAYTjlmKboPcBo+D/Gyxfdy2ZG6rLKsIsubIMPBFE+Tl
         mBcsF0b064ty9lE0m0uER2jv07ZLzexVVhlD7GsfEawrXD406wI50IGZFRS1oUyJlh/y
         sHn4R1cA7zvCIiiJkYjjQeH4Xju6nE9XJqO4zdJrP+SeOrmGSDbmaPTiOWCucftfHR3O
         IpmpnzuCUDURhUaiIL5hSvkg1cMuJZqaG2z152VijaJw+SZT2N/MY1thT4IXUMhSNfhm
         axvrmTMMiReiWFswxiuM89HrAFzzbuNoNCUmsA9Y/iV7as7EneZZJjq/qR4BdO+7EQuN
         VPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OTsuLTZ/FRMZyfy0BZfU4pYmxBxgwTorMU5kJlW3azw=;
        b=Mn3ItyAkudZvi5KInksm391PZak60+viwTfIFK7Vj91eHzdPz10noR1C3LlMr3mkhV
         vjj3qa8r+CER2STnwfWVXRV9E0cvxz7mahhwWjqvSgRkACCrTvRj9HPx1iYhp6fkHjCO
         +Frr5C1Aw0QcK7JhKS2ViP2Tts4mO2TzeOQI9c/POCuCLvwghdFgz1ajtThT+/gNhPn6
         XJlPMOnhj+5Hu4nVLyZP9WtItyGxsDPMFBHHF+qdoqkLxESgEOj7clXh1/Q4BigBAs6u
         8sANylD/HgkOM6VChbmibVUvq9xQ5oZg0A/+5U6vbdy6pwwOq8dBwiPphmFt8yUYWtli
         1O8Q==
X-Gm-Message-State: APjAAAWVojLvpKwG28UN4U2zk1zGP3IvaS7BrfXzhoIyJIWMNf1Uv7S0
        7jjKhh3iIx+hnp02nx8a21XCyQ==
X-Google-Smtp-Source: APXvYqwcqybgQw6cUHPMIhB66HrmgN0QaOkCMYxkmK+cRE0WqqlPX71eQ9d1q8NiFsjXARskyD4n9A==
X-Received: by 2002:a05:620a:7da:: with SMTP id 26mr2113272qkb.119.1569331281989;
        Tue, 24 Sep 2019 06:21:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id o52sm1122890qtf.56.2019.09.24.06.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:21:21 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:21:20 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     Filipe Manana <fdmanana@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for...
 (forever)
Message-ID: <20190924132118.egtvk6mxmh37wl3h@macbook-pro-91.dhcp.thefacebook.com>
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
 <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
 <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 07:07:41AM -0400, James Harvey wrote:
> On Tue, Sep 24, 2019 at 5:58 AM Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > >
> > > On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gmail.com> wrote:
> > > > ...
> > > > You'll see they're different looking backtraces than without the
> > > > patch, so I don't actually know if it's related to the original
> > > > regression that several others reported or not.
> > >
> > > It's a different problem.
> >
> > So the good news is that on upcoming 5.4 the problem can't happen, due
> > to a large patch series from Josef regarding space reservation
> > handling which, as a side effect, solves that problem and doesn't
> > introduce new ones with concurrent fsyncs.
> >
> > However that's a large patch set which depends on a lot of previous
> > cleanups, some of which landed in the 5.3 merge window,
> > Backporting all those patches is against the backport policies for
> > stable release [1], since many of the dependencies are cleanup patches
> > and many are large (well over the 100 lines limit).
> >
> > On the other it's not possible to send a fix for stable releases that
> > doesn't land on Linus' tree first, as there's nothing to fix on the
> > current merge window (5.4) since that deadlock can't happen there.
> >
> > So it seems like a dead end to me.
> >
> > Fortunately, as you told me privately, you only hit this once and it's
> > not a frequent issue for you (unlike the 5.2 regression which
> > caused you the hang very often). You can workaround it by mounting the
> > fs with "-o notreelog", which makes fsyncs more expensive,
> > so you'll likely see some performance degradation for your
> > applications (higher latency, less throughput).
> >
> > [1] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules.html
> 
> 
> All understood, thanks for letting me know.  Not a problem.  I have
> still only ran into this crash once, about 9 days ago.  I haven't had
> another btrfs problem since then, unlike the hourly hangs on 5.2 with
> heavy I/O.

We are seeing this crash internally on our testing tier, we're still running it
down but it's pretty elusive.  I'll CC you when we find it and fix it.  Thanks,

Josef
