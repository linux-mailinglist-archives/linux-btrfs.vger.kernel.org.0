Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A492D2902
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 11:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgLHKeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 05:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgLHKeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 05:34:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEAEC0617A6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 02:33:05 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n14so16393383iom.10
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 02:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGeyHxcaSartUH8a9zi/n5M89k1R/VsJjZVNH2VjNf8=;
        b=rhaifCa7CeeBs4g1UcWVmP4YimLaS9df2d93jiIMajoAG/7eP1z1HVZbzEi5hg8UEq
         5xkRbSDsVcUsQ8caQmaPmc50pm2xSKJUHHv89yuiVoflU4iSe4G58ZtGd5GwixvwvcbY
         6k2QVt+VLLlUOehkL15mvCqxHMtpuog9gkDOOiOjsfVM5Mts0xpZkI3C1SUp5bYYY12m
         HZpk+xb3h/ytbPmIqJ4HJ5BK3k7kOcxncY6xsUk9o9Pucjsj18kcCLBqx6sOxhDtiB5a
         GOyGVtKmpPF6GKx6FxjkuVvXuWd1WdF8W9Nl+gjRPEN3cV0/764MNRATV+yN7zReCaTE
         mbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGeyHxcaSartUH8a9zi/n5M89k1R/VsJjZVNH2VjNf8=;
        b=V6UJLCSrinG6tSaO200ly/eKJe7vREBNr4rvAZ18P1WHKpRiRlWOp/Eit+9v2eMrWO
         r8bTwH+iNy4NF9AKxTmLCJLuPeygxO0aYsD07Mt4WSfWAv8uas8RTfrxyV0EVWgnwLHf
         DOW8dSgUnBHIb08nUtyfZp30mYDM2yMMxo5PDMdbMHuZ8Z6hQ/p7iTh/PxM6NQu7NcMW
         9OUB/idxvFhBr7XXwieg5mf4fcRE6T5d9XC1hX75PusOe3UAatZsIzxJlMCw4IKNQ9gQ
         nluoxNO2HjHwg6kLzWzETUEMmwtJLdANrpVFjvSIxsYxHARRT1oBrBwAHdOLOmj5Frgg
         AVbQ==
X-Gm-Message-State: AOAM530kFobbpquY//Qx4CJue+Tc+6FGZmyLr8n48V9V8a8z/NktOIDb
        NdWPn28oUWPOjmkWOitIqa0yfYx4mytlvX/TsRyLHcah
X-Google-Smtp-Source: ABdhPJwUtVkF5KK8bjJwJ6mT/N0sXgZohXGLl5WoZVYcTW9m09t8FBTlb8xDrOVCux5BE14r/ee2LmYvilpDokUw58w=
X-Received: by 2002:a02:cd2f:: with SMTP id h15mr23224325jaq.37.1607423584829;
 Tue, 08 Dec 2020 02:33:04 -0800 (PST)
MIME-Version: 1.0
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
In-Reply-To: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Tue, 8 Dec 2020 20:32:53 +1000
Message-ID: <CAN05THRxZq87K3YiHzDjHR+n4uPEWx1ocNWrWXBGr3Pi-sZF2g@mail.gmail.com>
Subject: Re: btrfs-progs license
To:     Stefano Babic <sbabic@denx.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 8, 2020 at 7:53 PM Stefano Babic <sbabic@denx.de> wrote:
>
> Hi,
>
> I hope I am not OT. I ask about license for btrfs-progs and related
> libraries. I would like to use libbtrfsutils in a FOSS project, but this
> is licensed under GPLv3 (even not LGPL) and it forbids to use it in
> projects where secure boot is used.
>
> Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) and
> also libbtrfs. But I read also that libbtrfs is thought to be dropped
> from the project. And checking btrfs, this is linked against
> libbtrfsutils, making the whole project GPLv3 (and again, not suitable
> for many industrial applications in embedded systems).
>
> Does anybody explain me the conflict in license and if there is a path
> for a GPLv2 compliant library ?
>

There are always paths when licences conflict.
One path I have used successfully in other projectss is just to write
a replacement from scratch
picking a licence I am more comfortable with.
