Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D67231E4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2MN2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2MN2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 08:13:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6529C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 05:13:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r2so16330587wrs.8
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NvUEiPvBtsLAhj3GXmi4ey524kQtpgBssPAS19ywo/Y=;
        b=p0/SR82Hy4JOOvv6U5VWGP6WfPTBeCk2H407qjlgQXYxyA7TRbKfSaSqgL9JBGQGBS
         O3oXLFecQudaHWs1KDxWq+b4ucUGqvXQkUdXemb0uxFE/2gXYuV60nDfI7oBz7krbWsy
         jMSJlnYdJJVznrRmrFFOdQIcn0yMwZgsTQbzzzuFVWmkl0hVYcbacrQw6UfkbhorSnQN
         lHbXcgzSJ3yC39oHWO27+bqRmtCTW0YjqLA+5sqUL66EtzQlbz0FOV/mfx5NPQOOPyhl
         Hx1mEBBpKkCOoSuFIavtiDPUJeWVMemCUVn8iD+uoU6U6flGDVCSMj6Hxqppz3pqWDVS
         mX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvUEiPvBtsLAhj3GXmi4ey524kQtpgBssPAS19ywo/Y=;
        b=QgoPmKweVeeco6AcdyQPil8t9+Opv4aWYkIC1XuJPszabg3u44WcXTlCKSrBy1ibew
         bC5d3EkjfjztP+Q7lHlNcCNUZfrRhHoicRVi02MwAAR8z8YMTr02pTfOCXF2c9sUBE41
         sa7SROlwKnpJFQLtypuDpAYPRn5NIha7eSLWJy8AM4LKc5YBvds1XcnHsv3SvVvYi52U
         XwJL4+zJmFhywpz/KpMSH748vHFIdw0gzgjoumtFjBCvKdAImNOXyhRR5R7AuSS2pirM
         zKj2wwKSOz7xm7At6kyLT4yDYNJl+N0omkKlWI/MiZALc+nLW4AKE22g5bEceEJTLADK
         Od/A==
X-Gm-Message-State: AOAM531vIwzzlflOnXB+G8qO1tNUo4VT1uuDD846LQH+KP94Io5TkRD1
        G9950Clq/oeqdTbWTjsIAhbB0Iu2
X-Google-Smtp-Source: ABdhPJyQdEebqvI93Ctg0HzlO8uJXDgnCiClGbOR431zkayAruKQj7jrUjgtXEszNnaMikNpJaiQmQ==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr29668292wrr.390.1596024802992;
        Wed, 29 Jul 2020 05:13:22 -0700 (PDT)
Received: from vm1 (ip-78-45-45-209.net.upcbroadband.cz. [78.45.45.209])
        by smtp.gmail.com with ESMTPSA id n18sm5624885wrw.45.2020.07.29.05.13.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 05:13:22 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:13:15 +0200
From:   Zdenek Kaspar <zkaspar82@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Re: using btrfs subvolume as a write once read many medium
Message-ID: <20200729141315.5c8eaa48.zkaspar82@gmail.com>
In-Reply-To: <20200729102947.GA3703@twin.jikos.cz>
References: <VI1PR02MB58697B26A91E68507032D9CDAE700@VI1PR02MB5869.eurprd02.prod.outlook.com>
        <20200729102947.GA3703@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 29 Jul 2020 12:29:47 +0200
David Sterba <dsterba@suse.cz> wrote:

> On Wed, Jul 29, 2020 at 09:02:14AM +0200, spaarder wrote:
> > Hello,
> > 
> > With all the ransomware attacks I am looking for a "write once read
> > many" (WORM) solution, so that if an attacker manages to get root
> > access on my backup server, it would be impossible for him to
> > delete/encrypt my backups.
> > 
> > Using btrbk I already have readonly daily snapshots on my
> > backupserver. Is there any way to password protect the changing of
> > the properties of these subvolumes, so an attacker could not just
> > simply set the RO property to false? Any support for a feature
> > request?
> 
> I could dust off my old idea of so called 'sealed' subvolumes, that
> would do something similar to that: it could start as a read-write
> subvolume or read-only snapshot, switched back and forth rw/ro any
> number of times but once it's set as 'sealed', no switching allowed
> anymore. It could be snapshotted again or deleted.
> 
> For your usecase, the deletion would be still be a problem though and
> protecting against root actions would need some countermeasures
> outside of filesystem reach.
> 

Maybe make them single-sealed aka removable only in "single"
user mode? Together with LUKS protected rootfs it could be sufficient.

HTH, Z.
