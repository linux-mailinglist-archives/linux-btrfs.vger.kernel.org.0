Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F1B23DEAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Aug 2020 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgHFR2n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Aug 2020 13:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgHFRBB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Aug 2020 13:01:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91341C0A8886
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Aug 2020 07:12:55 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 77so12063848ilc.5
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Aug 2020 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4WhRyTMfBl5Hy0UUmPBTAiQu2ybjyTRDD1rWylSYzfU=;
        b=CcLjoNwNLklOIxsREOgKvJajLcmgvTaskLNisIk+d+7bMhPxF2/fQsUsgm/BJoStoS
         eBRv/wkoDb3PUj+twRTPeRdnIBpgn5zRLnr7z3ImZH895170kPoJg7O34qZR+GOTPOOK
         xpBuvpyEmrmkTXcn208dcDg1JxEgWmoPIk89tc95dv46HkMZCWuQ4PBvNjQBUFuwtTNx
         yhp0SabH9Rh/2INl4qmskpTWt3GkveXqdnf9u3B+mw7gyhW095AtxtLK8C0wottjc5PM
         HMw1tBN1jTeGV7MyVwpTBHxqZyuVZQVhQDjzszH58kTG5hXZ5Gi/SOKm6lAS3SxNewqq
         3ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4WhRyTMfBl5Hy0UUmPBTAiQu2ybjyTRDD1rWylSYzfU=;
        b=GXjHuyR6nPzritW6XfPBwM3zBCR8lenJaYXfAPhCwC6kWakEVzeZDaVlthCBsIvcHi
         sNMZiMo15lyZUa0fJq9dpjO2OiUf9aa1RQ0zYCAfOivui80Sc0G4dnAehK1Im/O8ox69
         bxcAtoyHpRA2TuVdxsQOdSSkBj2oCrYzrO6tbzDv7VHw0K0SPTIwIcySFPycNf8oXqB6
         eVn9mYKXLS8vS1wsvdArowF8Y2K2tkNauOx8thsqmUSxr+sROv5wYpfrT1yEe13yAu9Z
         9gTTNU8Rf0qnzcw4ZIgoi4Q1jwmUs+L9E3nbftnzZWoeNdU8M/i90Ec0wObrQhw3GPjJ
         Y/hg==
X-Gm-Message-State: AOAM530yZVQDiPAftcGpswtK3JX85dAZ0naj14d65xrbM472k5tm41Z0
        6L/KH48P+Lv05hblujl5JssLo7IZfRPwk5doKo8=
X-Google-Smtp-Source: ABdhPJyfwbAUt4TWy45FdSAMxN88xp9WsCYgBU0ylr66lwOn0tbzB2GOWoTw3dcv1SyIUyZbjtYB3ly22LrXLpZNUKE=
X-Received: by 2002:a92:5a92:: with SMTP id b18mr11533323ilg.9.1596723174776;
 Thu, 06 Aug 2020 07:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200806072906.358641-1-wqu@suse.com>
In-Reply-To: <20200806072906.358641-1-wqu@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 6 Aug 2020 10:12:17 -0400
Message-ID: <CAEg-Je99pQ4XRZg-F5a3bGTvGHg+EUyxJGCbfqRfMbEm76odVA@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: docs: update the stability and performance
 status of quota
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 6, 2020 at 3:32 AM Qu Wenruo <wqu@suse.com> wrote:
>
> There are a lot of enhancement to btrfs quota through v5.x releases.
>
> Now btrfs quota is more stable than it used to be.
>
> So update the man page to relect this.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-quota.asciidoc | 43 +++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/btrfs-quota.asciidoc b/Documentation/btrfs-quo=
ta.asciidoc
> index 85ebf729c2fa..1c032f11d001 100644
> --- a/Documentation/btrfs-quota.asciidoc
> +++ b/Documentation/btrfs-quota.asciidoc
> @@ -23,16 +23,47 @@ PERFORMANCE IMPLICATIONS
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>
>  When quotas are activated, they affect all extent processing, which take=
s a
> -performance hit. Activation of qgroups is not recommended unless the use=
r
> -intends to actually use them.
> +performance hit.
> +
> +Under most cases, the performance hit should be more or less acceptable =
for
> +root fs usage.
> +
> +There used to be a huge performance hit for balance with quota enabled.
> +That problem is solved since v5.4 kernel.
>
>  STABILITY STATUS
>  ~~~~~~~~~~~~~~~~
>
> -The qgroup implementation has turned out to be quite difficult as it aff=
ects
> -the core of the filesystem operation. Qgroup users have hit various corn=
er cases
> -over time, such as incorrect accounting or system instability. The situa=
tion is
> -gradually improving and issues found and fixed.
> +Btrfs quota has different stablity for different functionality:
> +
> +Extent accounting
> +^^^^^^^^^^^^^^^^^
> +
> +Pretty stable, there aren't many bugs (if any) affecting the extent acco=
unting
> +through v5.x release cycles.
> +
> +Thus if users just want referenced/exclusive usage of each subvolume, it
> +should be safe to use.
> +
> +Limit
> +^^^^^
> +
> +Should be near stable since v5.9.
> +
> +There used to be some bugs causing early EDQUOT errors before v5.9.
> +But v5.9 should solve them quite well, along with extra safe nets catchi=
ng any
> +reserved space leakage.
> +
> +Corner cases and small fixes may pop up time by time, but the core limit
> +functionality should be in good shape since v5.9.
> +
> +Multi-level qgroups
> +^^^^^^^^^^^^^^^^^^^
> +
> +Needs more testing. Although the core extent accounting should also work=
 well
> +for higher level qgroups, we don't have good enough test coverage yet.
> +
> +Thus extra testing and bug reports are welcomed.
>
>  HIERARCHICAL QUOTA GROUP CONCEPTS
>  ---------------------------------
> --
> 2.28.0
>

LGTM.

Reviewed-by: Neal Gompa <ngompa13@gmail.com>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
