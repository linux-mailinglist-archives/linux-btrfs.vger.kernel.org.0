Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6ABA1C0516
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD3SrH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3SrG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 14:47:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC5C035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 11:47:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so8302234wrm.13
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=flWxytFlfc2AalJWVP79qDFwQqQhnDLWc16EGX+Tc0g=;
        b=QWWXJg6DH82OkAHWZU6Sqy1N/SLsj+LzTK9xmKXG6fLYIehQxoKA9GITfb9Xkpck69
         4YPST21Yk0vnSnX/UM5Wq/britC2YOsfQlJd1zG0h7YC01q+jdnXSzvuziZ1QD/vNT/3
         ezlm2lMFQ6EfY0GrRRHxq+mY3cC70QCErBcebOFqM1LHIQLl0NajLnF5t6eBAXME27wu
         t2fX7iNjCzerfzwdxXZoxIQ0VLArJaRJ3mb7ALn1D/FOInxofy4fooNhZ4Auw07lrKbK
         SouMs92lWsvgxNElrJVModr+IJmgWqz1V9e3Te3MlabbJOF6nYjSKsn7MO/lGcY4f6Tt
         OuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=flWxytFlfc2AalJWVP79qDFwQqQhnDLWc16EGX+Tc0g=;
        b=kfCW093VaTo8K5X8PjhiYa1Um3lS2BwxcviERCk0fpGNU6T2tg5CeEZKtsGAv8kvFI
         WJE14w/kvs0FoBIqj6iWs1avjimHggFcsbTykVV+W8XnOO1vWqyZ6JhtQMv7bqUdlK2b
         8F9Bj3u8GbVZZAOYa3MVO/RVF0D34bHIDrOHdiSY6OaBdNlN206+DUNRMHigJ8n00qfs
         xOC4Q0S7QN4f+OvSS4SXvWNNSNqAlRXJhlgmelsc0+m/FOAdJVGNb/9RE3paMe2OHyuz
         BrJSbA1u4qwNUEfxgEq9q6lefXTnmziYwvlhkcYPbVxWy4qUdo4zX5ubcEsBb2g+K8zX
         1DxA==
X-Gm-Message-State: AGi0Pua3Iga3sbfDOv9poCgM+4Ch8yJ44ET/m5/vfVebhN4JFaGvt4oF
        DteQyvEEIuoKwe4lyqAeG/BJvjgiegljCHgeExQMF9U0V+A=
X-Google-Smtp-Source: APiQypKbclfoQxwCDpEyK03pfy+EaF1Xj901771Ec9CJN7BzUB82y3rdnYISRk32MGnvQjvXum9AS/IfPDXJ7teGm44=
X-Received: by 2002:a5d:6148:: with SMTP id y8mr5337882wrt.236.1588272425307;
 Thu, 30 Apr 2020 11:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com> <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
In-Reply-To: <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Apr 2020 12:46:49 -0600
Message-ID: <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read
 block groups
To:     Nouts <nouts@protonmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 12:40 PM Nouts <nouts@protonmail.com> wrote:
>
> Thanks for your help. I compiled btrfs-progs v5.6 from github.
>
> Here is the dump from /dev/sda : https://pastebin.com/e3YZxxsZ
>
> And btrfs check returned an error instantly :
> Opening filesystem to check...
> ERROR: child eb corrupted: parent bytenr=5923702292480 item=2 parent level=2 child level=0
> ERROR: failed to read block groups: Input/output error
> ERROR: cannot open file system

Ok try:
btrfs insp dump-t -b 5923702292480 --follow /dev/sda

Qu might have an idea. But in the meantime, my suggestion is to try to
mount with a newer kernel. In order try:

normal mount
mount -o ro
mount -o ro,degraded
mount -o ro,degraded,usebackuproot

And if any works, at least you can update backups in case this file
system can't be fixed.


-- 
Chris Murphy
