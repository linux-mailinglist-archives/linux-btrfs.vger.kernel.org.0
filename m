Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0498241558A
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 04:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhIWCua (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 22:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhIWCu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 22:50:29 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA046C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 19:48:58 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r1so4823937qta.12
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Sep 2021 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WwYknSQ6CSbD8TmQ3ae/foyPdcAnAOjNbkzrLoFeM5U=;
        b=lSr85jb0HeE19PVIX+iF9WUNUUaw7/VlNPawwV0moz2ajkWZ/qg2iEvlbQ0T8Zn4A6
         t/AeSDSCOt/M4Bx6z9pXbs3V195RDG8YbwGy4TSvp48EcuJyHu+EIOolGX2Ny/g8rWpn
         zMqGv434K7M13KCOogPIXeP1buMxJY7xNqAaXiwibNUQqOoLXT9622NiFmfd/PsIGlZ2
         godaffvWboXuT40TS0vvzqlju9noK4U8q9ocE3GwNmkGqyDTq+x9AwYHPF5C+ykWWYOE
         lZIzgOD3XwMOMiqZ7QGYURPh4QIE27j0QjX42ROv4/HFCaOaiofCvh5VJ+2S+PJJlf2d
         rx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwYknSQ6CSbD8TmQ3ae/foyPdcAnAOjNbkzrLoFeM5U=;
        b=UR1Ga1FZVyyTDkNFNJiJYA76aMfWRonKMg+v2RDg7niMpuIFCoPcbcd7YYAMdeEjD2
         PcgwtRmWdXT7ahxTWd6lD3xVPo6JuH/sgVKO1BkhHdxPgK0IkQOeIXP8O/hTpqQ0Pmti
         QrUy6snj2+TPoLRTH3VegTlCPcdIwEA+htOCDfCJiJDarj/32L8SGu0UZYlLLpjTu08W
         Lk+clGojIRAQ507GnXU+GJAj00VdqNWU59OeDJX8cTuH3pjaf92NcB2lov6/v26IrTNx
         bTmcG1rdlwyqgo2Rhm4jICd0MRUjeo8OYHIq3yeMqPxC/7YWAP1gHAytNqjUw0CTp2xb
         zMbA==
X-Gm-Message-State: AOAM533XPSo3dcnamTHlKFzgQtcsRROxAcZ/zSNjbDHmdllcfLjvglaU
        STuquVJyGgKwp9FSKI7ycTQ=
X-Google-Smtp-Source: ABdhPJxxGXjkaZDx9de4l1+6flIWOtb7lPuI9djOgHzg8kS1GYy8xqB7x1+D5Bb97c47xaCdZc0zJw==
X-Received: by 2002:a05:622a:11ce:: with SMTP id n14mr2727863qtk.374.1632365338043;
        Wed, 22 Sep 2021 19:48:58 -0700 (PDT)
Received: from gtw.localnet ([2600:1700:b511:30d0::41])
        by smtp.gmail.com with ESMTPSA id y23sm3331176qkj.128.2021.09.22.19.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 19:48:57 -0700 (PDT)
From:   "Garry T. Williams" <gtwilliams@gmail.com>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Btrfs progs release 5.14.1
Date:   Wed, 22 Sep 2021 22:48:56 -0400
Message-ID: <11964729.O9o76ZdvQC@gtw>
In-Reply-To: <20210922095044.GS9286@twin.jikos.cz>
References: <20210920162224.27927-1-dsterba@suse.com> <e4fcca2f-6515-83ac-e4ba-39e2f0cdf423@gmx.com> <20210922095044.GS9286@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wednesday, September 22, 2021 5:50:44 AM EDT David Sterba wrote:
> On Wed, Sep 22, 2021 at 09:26:50AM +0800, Qu Wenruo wrote:
> > On 2021/9/22 09:10, Garry T. Williams wrote:
> > > On Monday, September 20, 2021 12:22:24 PM EDT David Sterba wrote:
> > >> Hi,
> > >>
> > >> btrfs-progs version 5.14.1 have been released. This is a bugfix release.
> > >
> > > FYI,
> > >
> > >      === START TEST /home/garry/src/btrfs-progs/tests/fsck-tests/013-extent-tree-rebuild
> > >      $TEST_DEV not given, using /home/garry/src/btrfs-progs/tests/test.img as fallback
> > >      ====== RUN CHECK root_helper /home/garry/src/btrfs-progs/mkfs.btrfs -f /home/garry/src/btrfs-progs/tests/test.img
> > >      ERROR: /home/garry/src/btrfs-progs/tests/test.img is mounted
> > 
> > This means your previous run has hit some errors and the test image is
> > not unmounted.
> 
> The test suite is designed so that it leaves the last state where it
> failed to allow analysis. After failed tests most failures can be fixed
> by 'make test-clean', manual check can be done by 'losetup' and 'mount'
> looking for the paths from the git repository.

Thank you, David.  Running make test-clean was the key.  I didn't know
that was required.


-- 
Garry T. Williams



