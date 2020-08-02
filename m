Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239182354D8
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Aug 2020 03:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHBB4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Aug 2020 21:56:11 -0400
Received: from smtp.sws.net.au ([46.4.88.250]:57704 "EHLO smtp.sws.net.au"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgHBB4L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Aug 2020 21:56:11 -0400
X-Greylist: delayed 2927 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Aug 2020 21:56:10 EDT
Received: from liv.localnet (unknown [103.75.204.226])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: russell@coker.com.au)
        by smtp.sws.net.au (Postfix) with ESMTPSA id EF036EC91;
        Sun,  2 Aug 2020 11:56:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
        s=2008; t=1596333368;
        bh=BCuyspo0HfsWAABzvuCCX9c6oRmjgEj9kMiJ9S+97K8=; l=436;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLMfaT6tSQh+5/VwVHWPH+NY5sMfG2pdBhjF28WEzRCy7/rPMzpMZC1QONsWvJAt6
         Nl3zHyxhTjqDFgsSE7YJvL7cdZjX8WX8cNK64w3jR4XIafxQU7hdW9+iAtULtSSORw
         53t6E0Z+oNTeO2ijkZlyv8Eiq5EXQ23KK81JMUeQ=
From:   Russell Coker <russell@coker.com.au>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: balance loop with raid-1 on 5.7.6-1
Date:   Sun, 02 Aug 2020 11:55:47 +1000
Message-ID: <3572555.96P9zsVvc0@liv>
In-Reply-To: <927d2761-dfa8-ca50-a1b0-155d70828bdf@gmx.com>
References: <13086015.6n0rELWJ5N@liv> <927d2761-dfa8-ca50-a1b0-155d70828bdf@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sunday, 2 August 2020 11:19:21 AM AEST Qu Wenruo wrote:
> This is a known bug, and backport for 5.7.x only arrives at 5.7.11.
> 
> So please update your kernel to latest 5.7.x stable kernel, or try
> v5.8-rc kernels.

Thanks a lot for your advice and for replying so quickly.  I'll try a newer 
kernel.

Keep up the good work everyone!

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/



