Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04E624769
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Nov 2022 17:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiKJQsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Nov 2022 11:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiKJQsW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Nov 2022 11:48:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27DE450A5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 08:46:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a67so3925907edf.12
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Nov 2022 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1I3FS0DcADfqBy7jm2/5OUN7/Bad2NO71vszjtSnnQ=;
        b=KYrwmD34AEUS3qo7YpLy+uNAmIxV89i3/l7JLM5IXScntr2IuLfEpBqWXdJOQVPnxH
         Mfu7GCwnal3xZ4i+JNICnBtoFjvMFsIlg/09Sv5biw1WggNjhV9QOSu4FSCS9x4YRROd
         9wH7lSONfBjpElExjba8LGGkp0SptB198SLlvHoN5QGpIOlDx7+PGriEgqDzcCCI++32
         hB8Z4h0Egwn2zRduGz836xL2OPJwoto6P8ucMaijmml0rcrbP8SmmQMZE9kxv4/m+H86
         4zOq8/U1iWGN74T2dkejN5ba9ETjmA7bb9AFAcI6S6ovRU81z8UCkHcze2KgukCNgx0V
         XzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1I3FS0DcADfqBy7jm2/5OUN7/Bad2NO71vszjtSnnQ=;
        b=GNE3U2Rx2Y46pKkxZhS24mBrnMZ7xHjxCVeFrnaC878HWh1pCWtcwYBVq57A7i6VVD
         kW5Fh+/SEIE3PvLW9DR57yrs4JMn2HJcXdqZMpqeW/csBweE3Cljes4zN/hdSkQ8ohIK
         JEeDguT2ttDLf+/Rjm0P9TbMoXFNBJdxtsf1w4C6jB+Gu2Nq6VTvA2RAWy70DBA+U6Ll
         JGuCY0Rwk5VGmTH36Zwp053FmORLIwIC7nCzxw4PsnTdw694dgPD95FRzImccBQmCy2V
         pRvW0JhG1xVmBqYoS6lPlkqMg9YwmjAsB+PyLZpNAdAnBinPUnZ6490bOW2FJEQ6vlrD
         IFqg==
X-Gm-Message-State: ACrzQf2VYdBzL5O4fP1YKgU+yUqMP2tAlDk/dqHu6eScAt2mUKZm48Pz
        UlRQ2zn4SAUXA/EHHbwKLjC2JXClEMVgI0ruyI8Fq87kPdkk8w==
X-Google-Smtp-Source: AMsMyM6ImhjjzrIdtUVXjLj3NMxICT5DUS+9imyxjzma9Djnod9PRJUUS3BoLcnhX9EaqYk/mCa9Wqy1HojLhK5Iq0k=
X-Received: by 2002:aa7:c486:0:b0:457:35d4:ac66 with SMTP id
 m6-20020aa7c486000000b0045735d4ac66mr2637634edq.415.1668098809101; Thu, 10
 Nov 2022 08:46:49 -0800 (PST)
MIME-Version: 1.0
References: <G1N4LR.84UPK81F80SK3@ericlevy.name> <20221110121249.GE5824@twin.jikos.cz>
 <X4X4LR.21Q66E3SQOHF@ericlevy.name>
In-Reply-To: <X4X4LR.21Q66E3SQOHF@ericlevy.name>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Thu, 10 Nov 2022 11:46:38 -0500
Message-ID: <CA+H1V9xCmejh0Tx80czJOqTVmwAM7gCwfKJzgW6Mmkwu+tObYg@mail.gmail.com>
Subject: Re: option to mount read-only subvolume with read-write access
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> In some scenarios, upcoming changes to a file tree, intended to become
> the default mounts in future boot sessions, will be staged in a closed
> environment, which may include use of "chroot". It is helpful for the
> subvolume to be read-write in the environment created by temporary
> mount points, but still protected from accidental modification through
> its physical location on the root tree.

I think for that situation you'd want to make a snapshot of the
subvolume (which is currently mounted read-only) and then modify it.
You can then make the new subvolume have the name of the old
subvolume. This should allow you to keep the old data in read-only
until you reboot in which case the new data will be mounted.

Matthew Warren
