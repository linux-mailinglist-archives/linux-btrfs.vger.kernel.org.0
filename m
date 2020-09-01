Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E848425853C
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 03:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgIABoW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 21:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgIABoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 21:44:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A87C061757
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 18:44:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e17so1192030wme.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Aug 2020 18:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FM3aKZkV4xM8df9tyK4no65MIyj7z/tjTcOsvfsvO3o=;
        b=DW/UlJlh/1mjoW4r60w66arWfVoiSjncSZhmPXWn8naiNdrjz0egs6UyE/HsF2f0DH
         RRfNxb7okKAI0ZSnDm3POgYOWLUhfdpszymosmh5rnnja73LcFzlVRSZWGWN0fGL8p54
         CkPOKYU0rUaWcmR6zkqHr0CgnrOhcmXn/p4asST19wxhGwoHhaq234pEJscLRzUGo7DN
         ywY+nh1QwVbRXgySdL5Nwv1dUEmPyFygM83IkXnHjS53hGLBdG86mcTaSn6pTm2Z50mv
         jkOeKJam56NpgY31Czu5tFnAdysMl4VlWbsbrzPzFgsHwusUv8LJmLxmpLHMqt6Ulcv8
         0tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FM3aKZkV4xM8df9tyK4no65MIyj7z/tjTcOsvfsvO3o=;
        b=uQRKWJNboi4/1vmDkYnoRkRd/wU+GQE0s2hCXfjBtn09kRIIFl2mSrl242Qx7xOw0m
         W/M0Z6HFaZzYvx2MpGB1ihSFy1qonO/rcnLsHHdUr6iPMIe3R/lAcXA48TZaol2HEGG1
         +EB3p/5OmvZ4pfUKc4dtypm6n9HVMZZIT0eyQ4M7NXtaHetEO2kDsEazXdw+tSFjQRTi
         GKyx7iBpxQ45Oa9ZIZmMEx6ghzComfyYTUteZb0PFZgWupb3XzAjPoHyeE4RB8GmKEoi
         I+5RP8HFzstlziofgqOrBi1bt0IEycwSb6pkJF+Oe2EQFvGXNX9qAYTab2P7cIT56l5X
         PxPw==
X-Gm-Message-State: AOAM530i38VjaU/wL2aSKt976BLWonpUGqRPABBQP35GAUWMcv7flIZR
        J6QRv3PP+qY5hH75nxC4R2iHsQiWPB3Sb7PY9+LQF/rstuUrIw==
X-Google-Smtp-Source: ABdhPJzrcKiBVWYHu8VZxRDauuIfuqFZ99yDp7PGMrU3o+OkOyjokoxgW1HTJ0rAtC/GCKQG7QrMLsAUcFj4sgo66IY=
X-Received: by 2002:a1c:5581:: with SMTP id j123mr1812952wmb.11.1598924660394;
 Mon, 31 Aug 2020 18:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
In-Reply-To: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 31 Aug 2020 19:43:31 -0600
Message-ID: <CAJCQCtS+8ZXEYdYTKuTDz9vDA4pL5etRm8k20ea58pXpC9n5QA@mail.gmail.com>
Subject: Re: new database files not compressed
To:     Hamish Moffatt <hamish-btrfs@moffatt.email>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I wonder if this is at all related to a case I've seen where VM images
aren't being compressed at all. 'nodatacow' is not set. Does not
matter if compress or compress-force is set. And if I merely copy the
file, --reflink=never, the result is fairly well compressed.

VM is qemu-kvm based. And I've tried either cache none or writeback
(maybe both, I forget) and cache unsafe. No compression.

*shrug*

--
Chris Murphy
