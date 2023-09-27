Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77D7B01C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjI0KYM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 06:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjI0KXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 06:23:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C9558F;
        Wed, 27 Sep 2023 03:13:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD3BC433C8;
        Wed, 27 Sep 2023 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695809638;
        bh=vL9Xulcdmo5JSJCoGs/OksSLrv/rwxVoIWne65a98n0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lSxajg/KEYUu3Z9v2D6wOwSkeEgTqRd5oovBSeBCw2LWyrC9EXbCrBQvTO+30qZji
         UDJO/EvQ3j6NiQX0a57wOrv1jEWG/luvGzfVXxzV8sPdtmkvOhQ5Qa3B3H1cPathAo
         GYvxxf9vxiKOegsMM2DnC7x8OyXlHL99FAHJ8T8Ga++VxUpVOmTRGzSNMRdXPRajXc
         9ki++bmGNafh1uI6iC5218CbO6qD6VFzYFJC74rpjsc5Qar3riDgGRykiJOJAQWYj4
         5PG0wyO2HZ/NKyFERkRLzWUv9PMvnQDATdnJzWShrkaqcb2Sqn+kB+O3E2coDJZkuY
         ARabQBZ/WJ0dg==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ae2ec1a222so4864005b6e.2;
        Wed, 27 Sep 2023 03:13:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YzzQExugH/zjVOdn03psfjz0gd1gOmsoQU7Z5lHhgv2AUjjU/R1
        OciFMtQfjwooBnejZROkz8B47imxs90JN7aDDjk=
X-Google-Smtp-Source: AGHT+IFMvw6paHkuhvVWQYQmCKaGOoG8tVw4kbov5K4W/k8FSbwNH21FChkOsIiyTP+mkLg0mIq+ZcudePVKfrU36X0=
X-Received: by 2002:a05:6870:2404:b0:1ba:2a58:b15e with SMTP id
 n4-20020a056870240400b001ba2a58b15emr1914738oap.2.1695809637922; Wed, 27 Sep
 2023 03:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230927014258.GB11423@frogsfrogsfrogs>
In-Reply-To: <20230927014258.GB11423@frogsfrogsfrogs>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 27 Sep 2023 11:13:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5sKfn82mqo3jMrdEZRB5irsNT6z9WrysPjBZ6pK6LoOw@mail.gmail.com>
Message-ID: <CAL3q7H5sKfn82mqo3jMrdEZRB5irsNT6z9WrysPjBZ6pK6LoOw@mail.gmail.com>
Subject: Re: [PATCH] btrfs/300: check existence of unshare arguments
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 27, 2023 at 3:18=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Make sure the installed unshare binary supports all the arguments that
> it wants to use.  The unshare program on my system (Ubuntu 22.04)
> doesn't support --map-auto, so this test fails unnecessarily.
>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  common/rc       |    2 +-
>  tests/btrfs/300 |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/rc b/common/rc
> index 41862c2766..722e3bdcaa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5333,7 +5333,7 @@ _soak_loop_running() {
>
>  _require_unshare() {
>         unshare -f -r -m -p -U $@ true &>/dev/null || \
> -               _notrun "unshare: command not found, should be in util-li=
nux"
> +               _notrun "unshare $*: command not found, should be in util=
-linux"
>  }
>
>  # Return a random file in a directory. A directory is *not* followed
> diff --git a/tests/btrfs/300 b/tests/btrfs/300
> index ff87ee7112..8a0eaecf87 100755
> --- a/tests/btrfs/300
> +++ b/tests/btrfs/300
> @@ -20,7 +20,7 @@ _require_test
>  _require_user
>  _require_group
>  _require_unix_perm_checking
> -_require_unshare
> +_require_unshare --keep-caps --map-auto --map-root-user
>
>  test_dir=3D"${TEST_DIR}/${seq}"
>  cleanup() {
