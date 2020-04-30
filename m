Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B0F1C0608
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 21:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD3TTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 15:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3TTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 15:19:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1EDC035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 12:19:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y24so3388432wma.4
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W4zysGg/Zz7CpASWG4cuPY+g2HVmp4Rx9Nscxbod4Q=;
        b=onQODyKzTMMw/CvUDRUBT7Phtuq+09vahTYkjA2mYxO1GHNsBOXkMw05kY+4PvKTGf
         dMTLCFTcMkNII7TiR7kNHUdFukIHizQhsnsreXUjEvR5/knAQ2I5woya5OTWL+gvMRjV
         O9UrVAy8PyKNThRG45ZW7EqF8qqmUnnJtTR4d75DoyxaU2IYTSzm9iHtsmQOcyFVZ7aA
         Zyhc/gQFm8q76vh9o5CrCuJ7kb2yK5/h+fX8DUbr9G+kGw4yUKPLjeiZEcFEv/tPMw2w
         qhC7NCW9rQCqKF+TWDtZmvI74WQFxSLAjrpMl2tx7z679lzR7BNykc35TDgJgXBX2lM/
         7O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W4zysGg/Zz7CpASWG4cuPY+g2HVmp4Rx9Nscxbod4Q=;
        b=KRGxyC/yooJfHXmlpk3bH4dF58YhGY+N4sAhmALLxmvbCGLOouCxbnHm7IVN0VGK3B
         mXR80236VpZ5IYs1lnjz+eGlYQfdqwQW678/nisgLbxwL6BITpdTJ/pdV+qVBt1ijJ8b
         AIdltfwU79/m4HRl+g69F04Mv11uj3YAT4eGEzkndbQebm4fXlLeQndWZK154Ma3P2GB
         BEkGhEZG7LMNrHZKterdync72JbIladNkGfggYyAiR23xaquvqMDWHqqhBJiI/F3Vi0h
         m/Xc0zLXSPmmaR/7PRGeIsvo5VvZDrHqn9hJsyWfKAnWM8+rPQMY466JpRz/jHdgLIEE
         ySkA==
X-Gm-Message-State: AGi0PuYieEq366varZ9vT8IQ9GaUfiGbCKxcoYw684eHRT0cWq5cCqVr
        337qa92eTpOhSNivIc2vGwBpJsIpNfXEMvsmdM+1Ew==
X-Google-Smtp-Source: APiQypIEACTJUvCshQ+eB/MA36HRUCe66OKqyb2mDHrRUSz6brPNz0ZbhYLbq7nPJ1lR9Ed9W0bmRR+OhiNkR7w8E9Y=
X-Received: by 2002:a1c:7d4b:: with SMTP id y72mr101148wmc.11.1588274351132;
 Thu, 30 Apr 2020 12:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <EvtqVyP9SQGLLtX4spGcgzbLaK45gh3h00n6u9QU19nuQi6g13oqfZf6dmGm-N8Rdd2ZCFl7zOeEBXRc_Whom2KYJA1eDUSQxgZPZgmI7Dc=@protonmail.com>
 <5oMc__tPC-OFYhHTtUghYtHMzySzDXlSlYC_S5_WjIFiA8eXfvsSxQpfaglOag0sNz7qtvMUzhCqdRzBOMokxeo2dFrfkWrLbBmmuWvME5s=@protonmail.com>
 <CAJCQCtT0mSYvN7FeCavsmKP9j_69JmZ0JdGz8ommhqag=GiM=Q@mail.gmail.com>
 <NmjvBWGDb0a1ZnPep0UnBmeFG4uSUMrxyiYDCir6RRsMyZzizVtCH_8tdd6Y_glmPbbusrKtVBCgGvV7Cc5UFCDqcvJ1PTgWi87x-0FacQ4=@protonmail.com>
 <CAJCQCtRWdovSOQd8r7YzxsQa4fxT9feB_R-nvG7BjvB-u1m2ew@mail.gmail.com> <XzvzKWYVgWGlgX7GSa5XGfQcMuM4od6BMpG63kC2X3thsAfl0i__swcKuMF3TcdiInqnifyiphevLoacMdYlEn7YDqj8JDLKFaZRZsoQx1Q=@protonmail.com>
In-Reply-To: <XzvzKWYVgWGlgX7GSa5XGfQcMuM4od6BMpG63kC2X3thsAfl0i__swcKuMF3TcdiInqnifyiphevLoacMdYlEn7YDqj8JDLKFaZRZsoQx1Q=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 30 Apr 2020 13:18:54 -0600
Message-ID: <CAJCQCtQ=hwE-wwPXEw_r+VOe36zsHYmpx7updj4JOMmQqQeM8w@mail.gmail.com>
Subject: Re: Troubleshoot help needed - RAID1 not mounting : failed to read
 block groups
To:     Nouts <nouts@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 1:05 PM Nouts <nouts@protonmail.com> wrote:
>
> Here is the dump --follow : https://pastebin.com/yx13mDfB
> Sadly, none of "mount" worked.

Yep. I can't tell from the check error or the dump output, whether
it's worth trying chunk recover again with the latest progs, or check
with --repair. But either of those makes changes to the file system,
so best to get advice from a developer first and in the meantime
refresh backups.

I don't know that a newer kernel will help in this case, because even
the latest progs complains. And the output from check doesn't give
enough information to know what to try next or if it's hopeless.

-- 
Chris Murphy
