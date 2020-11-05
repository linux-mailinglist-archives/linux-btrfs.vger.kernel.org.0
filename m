Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808A82A7D67
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 12:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgKELnf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 06:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgKELnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 06:43:33 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C563C0613CF;
        Thu,  5 Nov 2020 03:43:33 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id 63so506125qva.7;
        Thu, 05 Nov 2020 03:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4PwOWN3Ig1eHu/tpEeKtkfRvNsP+dQ6gFSlRreAygLw=;
        b=FUi6hUJfC6/4LWrx2AxUD84JbUAYFhg2cn7oMd9IbaqiXO6Y7Xxz0JOYEI/1zlPJAL
         cbKkod5VwAOVM6wsb17RdJSLEcicDo+YXLgKdKFiSAJVwqaQH8dE0BRrteD3WOz1LJGp
         uHaTdTz2HM13aYoP5KXUpiYmLMxYtrS6ZT9Pqe/z0XJFQruH3loSRwFiHdseaiqeFaBC
         JHcYmsVGpf4XdntZISE92h+TBWkmvYWAGaqs+Sl9yZDBza55ofZf7hT35G95zijIlV8B
         hJyxSkd0EY5F3R2pF/fhGan5lG7iEgAMhmSnL7b4tl2k22i8KoPEEZ/rqwzX1u3szj43
         oEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4PwOWN3Ig1eHu/tpEeKtkfRvNsP+dQ6gFSlRreAygLw=;
        b=eL/v+odpmswh5nc0OwL5rgaV3yfm7YD3Tl2rICFEEyamAiOoStj6pjboYXVghw+uMg
         3PdlzOwnFDQsFTSl7J0l5p42dwhbZLROsrhqlj8814NiaavuSkwftip/rgFaVB5zG74N
         P5JRkYo6ygWqtgurWC6NVRQuScHCrgfM0eVPwUGWCJ7a+y20RUh2mAX8slnMGZcuqglp
         XvfgZSTCqIS0TZhJjwG9c8FOW+i+D5n9/If8/4WUJgECTkv69tJOOcy71AZC7T+3vPdS
         6YRJKIlkJkVw0I+7/D2VGUeX9GTHRiAI2sDnZKJcEWmcZ03/C9uc/vv1WnaTTSn4KUwv
         BLOw==
X-Gm-Message-State: AOAM531qZItTAyAmclY/2PtSvMkZq7M08WdsUkOixpYI3aeuY+60FEnQ
        ajG1UnQPddDcqSNnl5xCY5dhsbaYxZ8JZMjvqQx5syzYuRc=
X-Google-Smtp-Source: ABdhPJxUc+at3GwITVHyf3cxyiVqJR0ZKZvaxe4KFrndSTP116+xDFfenhFNZB4l+58TcVOvLSO9g3vy/MmCSVPGrSU=
X-Received: by 2002:ad4:4e2b:: with SMTP id dm11mr1782097qvb.41.1604576612499;
 Thu, 05 Nov 2020 03:43:32 -0800 (PST)
MIME-Version: 1.0
References: <8ef2b30c248a05af25f563124f1b75cf30378035.1604522311.git.josef@toxicpanda.com>
In-Reply-To: <8ef2b30c248a05af25f563124f1b75cf30378035.1604522311.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 5 Nov 2020 11:43:21 +0000
Message-ID: <CAL3q7H5wRep3SjY=QD85MzpP8ABNbpWXWvWdfj89pPmQyLuE+Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs/220: fix how we tests for mount options
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 4, 2020 at 9:13 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Filipe noticed that btrfs/220 started failing with some mount option
> changes I made recently, but upon closer inspection this test actually
> fails in a lot of different ways normally, specifically if you specify
> MOUNT_OPTIONS, or if you make an fs with the free space tree.
>
> Address all these issues by reworking how we test that the mount options
> are what we expect.  First get what the default mount options are for a
> plain mount of SCRATCH_DEV.  This is used as the baseline, so no matter
> how the mount options change in the future it will always work properly.
>
> Secondly instead of specifying a rigid order of the mount options we're
> testing, which breaks if we adjust the order in /proc/self/mounts,
> simply specify the options we're actually interested in checking.  Then
> in the test function combine the common options with the new options
> we're testing, and then combine that with our actual options and use
> some sort magic to see if there's any difference.  If there's no
> difference then we know we have everything set as expected, if not we
> fail.
>
> This patch addresses the initial issue that Filipe noticed, but also
> fixes the failures when you specified MOUNT_OPTIONS, or if you made the
> fs with the free space tree.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, I like the solution and makes it robust.
Thanks!

> ---
>  tests/btrfs/220 | 124 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 77 insertions(+), 47 deletions(-)
>
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index 8f4ba5c6..c84c7065 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -39,13 +39,35 @@ test_mount_flags()
>  {
>         local opt
>         local opt_check
> +       local stripped
>         opt=3D"$1"
>         opt_check=3D"$2"
>
>         active_opt=3D$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
>                                         $AWK_PROG '{ print $4 }')
> -       if [[ "$active_opt" !=3D *$opt_check* ]]; then
> -               echo "Could not find '$opt_check' in '$active_opt', using=
 '$opt'"
> +
> +       if [ "$opt_check" !=3D "$DEFAULT_OPTS" ]; then
> +               # We only care about the common things between defaults a=
nd the
> +               # active set, so strip out the uniq lines between the two=
, and
> +               # then we'll add this to our $opt_check which should equa=
l
> +               # $active_opt.  We also strip 'rw' as we may be checking =
'ro',
> +               # so we need to adjust that accordingly
> +               stripped=3D$(echo "$DEFAULT_OPTS,$active_opt" | tr ',' '\=
n' | \
> +                               sort | grep -v 'rw' | uniq -d | tr '\n' '=
,' | \
> +                               sed 's/.$//')
> +               opt_check=3D"$opt_check,$stripped"
> +       fi
> +
> +       # We diff by putting our wanted opts together with the current op=
ts,
> +       # turning it into one option per line, sort'ing, and then printin=
g out
> +       # any uniq lines left.  This will catch anything that is set that=
 we're
> +       # not expecting, or anything that wasn't set that we wanted.
> +       #
> +       # We strip 'rw' because some tests flip ro, so just ignore rw.
> +       diff=3D$(echo "$opt_check,$active_opt" | tr ',' '\n' | \
> +               sort | grep -v 'rw' | uniq -u)
> +       if [ -n "$diff" ]; then
> +               echo "Unexepcted mount options, checking for '$opt_check'=
 in '$active_opt' using '$opt'"
>         fi
>  }
>
> @@ -173,116 +195,124 @@ test_subvol()
>         # subvol and subvolid should point to the same subvolume
>         test_should_fail "-o subvol=3Dvol1,subvolid=3D1234132"
>
> -       test_mount_opt "subvol=3Dvol1,subvolid=3D256" "space_cache,subvol=
id=3D256,subvol=3D/vol1"
> -       test_roundtrip_mount "subvol=3Dvol1" "space_cache,subvolid=3D256,=
subvol=3D/vol1" "subvolid=3D256" "space_cache,subvolid=3D256,subvol=3D/vol1=
"
> +       test_mount_opt "subvol=3Dvol1,subvolid=3D256" "subvolid=3D256,sub=
vol=3D/vol1"
> +       test_roundtrip_mount "subvol=3Dvol1" "subvolid=3D256,subvol=3D/vo=
l1" "subvolid=3D256" "subvolid=3D256,subvol=3D/vol1"
>  }
>
>  # These options are enable at kernel compile time, so no bother if they =
fail
>  test_optional_kernel_features()
>  {
>         # Test options that are enabled by kernel config, and so can fail=
 safely
> -       test_optional_mount_opts "check_int" "space_cache,check_int,subvo=
lid"
> -       test_optional_mount_opts "check_int_data" "space_cache,check_int_=
data,subvolid"
> -       test_optional_mount_opts "check_int_print_mask=3D123" "space_cach=
e,check_int_print_mask=3D123,subvolid"
> +       test_optional_mount_opts "check_int" "check_int"
> +       test_optional_mount_opts "check_int_data" "check_int_data"
> +       test_optional_mount_opts "check_int_print_mask=3D123" "check_int_=
print_mask=3D123"
>
>         test_should_fail "fragment=3Dinvalid"
> -       test_optional_mount_opts "fragment=3Dall" "space_cache,fragment=
=3Ddata,fragment=3Dmetadata,subvolid"
> -       test_optional_mount_opts "fragment=3Ddata" "space_cache,fragment=
=3Ddata,subvolid"
> -       test_optional_mount_opts "fragment=3Dmetadata" "space_cache,fragm=
ent=3Dmetadata,subvolid"
> +       test_optional_mount_opts "fragment=3Dall" "fragment=3Ddata,fragme=
nt=3Dmetadata"
> +       test_optional_mount_opts "fragment=3Ddata" "fragment=3Ddata"
> +       test_optional_mount_opts "fragment=3Dmetadata" "fragment=3Dmetada=
ta"
>  }
>
>  test_non_revertible_options()
>  {
> -       test_mount_opt "clear_cache" "relatime,space_cache,clear_cache,su=
bvolid"
> -       test_mount_opt "degraded" "relatime,degraded,space_cache,subvolid=
"
> +       test_mount_opt "clear_cache" "clear_cache"
> +       test_mount_opt "degraded" "degraded"
>
> -       test_mount_opt "inode_cache" "space_cache,inode_cache,subvolid"
> +       test_mount_opt "inode_cache" "inode_cache"
>
>         # nologreplay should be used only with
>         test_should_fail "nologreplay"
> -       test_mount_opt "nologreplay,ro" "ro,relatime,rescue=3Dnologreplay=
,space_cache"
> +       test_mount_opt "nologreplay,ro" "ro,rescue=3Dnologreplay"
>
>         # norecovery should be used only with. This options is an alias t=
o nologreplay
>         test_should_fail "norecovery"
> -       test_mount_opt "norecovery,ro" "ro,relatime,rescue=3Dnologreplay,=
space_cache"
> -       test_mount_opt "rescan_uuid_tree" "relatime,space_cache,rescan_uu=
id_tree,subvolid"
> -       test_mount_opt "skip_balance" "relatime,space_cache,skip_balance,=
subvolid"
> -       test_mount_opt "user_subvol_rm_allowed" "space_cache,user_subvol_=
rm_allowed,subvolid"
> +       test_mount_opt "norecovery,ro" "ro,rescue=3Dnologreplay"
> +       test_mount_opt "rescan_uuid_tree" "rescan_uuid_tree"
> +       test_mount_opt "skip_balance" "skip_balance"
> +       test_mount_opt "user_subvol_rm_allowed" "user_subvol_rm_allowed"
>
>         test_should_fail "rescue=3Dinvalid"
>
>         # nologreplay requires readonly
>         test_should_fail "rescue=3Dnologreplay"
> -       test_mount_opt "rescue=3Dnologreplay,ro" "relatime,rescue=3Dnolog=
replay,space_cache"
> -
> -       test_mount_opt "rescue=3Dusebackuproot,ro" "relatime,space_cache,=
subvolid"
> +       test_mount_opt "rescue=3Dnologreplay,ro" "ro,rescue=3Dnologreplay=
"
>  }
>
>  # All these options can be reverted (with their "no" counterpart), or ca=
n have
>  # their values set to default on remount
>  test_revertible_options()
>  {
> -       test_roundtrip_mount "acl" "relatime,space_cache,subvolid" "noacl=
" "relatime,noacl,space_cache,subvolid"
> -       test_roundtrip_mount "autodefrag" "relatime,space_cache,autodefra=
g" "noautodefrag" "relatime,space_cache,subvolid"
> -       test_roundtrip_mount "barrier" "relatime,space_cache,subvolid" "n=
obarrier" "relatime,nobarrier,space_cache,subvolid"
> +       test_roundtrip_mount "acl" "$DEFAULT_OPTS" "noacl" "noacl"
> +       test_roundtrip_mount "autodefrag" "autodefrag" "noautodefrag" "$D=
EFAULT_OPTS"
> +       test_roundtrip_mount "barrier" "$DEFAULT_OPTS" "nobarrier" "nobar=
rier"
>
>         test_should_fail "commit=3D-10"
>         # commit=3D0 sets the default, so btrfs hides this mount opt
> -       test_roundtrip_mount "commit=3D35" "relatime,space_cache,commit=
=3D35,subvolid" "commit=3D0" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "commit=3D35" "commit=3D35" "commit=3D0" "$D=
EFAULT_OPTS"
>
>         test_should_fail "compress=3Dinvalid"
>         test_should_fail "compress-force=3Dinvalid"
> -       test_roundtrip_mount "compress" "relatime,compress=3Dzlib:3,space=
_cache,subvolid" "compress=3Dlzo" "relatime,compress=3Dlzo,space_cache,subv=
olid"
> -       test_roundtrip_mount "compress=3Dzstd" "relatime,compress=3Dzstd:=
3,space_cache,subvolid" "compress=3Dno" "relatime,space_cache,subvolid"
> -       test_roundtrip_mount "compress-force=3Dno" "relatime,space_cache,=
subvolid" "compress-force=3Dzstd" "relatime,compress-force=3Dzstd:3,space_c=
ache,subvolid"
> +       test_roundtrip_mount "compress" "compress=3Dzlib:3" "compress=3Dl=
zo" "compress=3Dlzo"
> +       test_roundtrip_mount "compress=3Dzstd" "compress=3Dzstd:3" "compr=
ess=3Dno" "$DEFAULT_OPTS"
> +       test_roundtrip_mount "compress-force=3Dno" "$DEFAULT_OPTS" "compr=
ess-force=3Dzstd" "compress-force=3Dzstd:3"
>         # zlib's max level is 9 and zstd's max level is 15
> -       test_roundtrip_mount "compress=3Dzlib:20" "relatime,compress=3Dzl=
ib:9,space_cache,subvolid" "compress=3Dzstd:16" "relatime,compress=3Dzstd:1=
5,space_cache,subvolid"
> -       test_roundtrip_mount "compress-force=3Dlzo" "relatime,compress-fo=
rce=3Dlzo,space_cache,subvolid" "compress-force=3Dzlib:4" "relatime,compres=
s-force=3Dzlib:4,space_cache,subvolid"
> +       test_roundtrip_mount "compress=3Dzlib:20" "compress=3Dzlib:9" "co=
mpress=3Dzstd:16" "compress=3Dzstd:15"
> +       test_roundtrip_mount "compress-force=3Dlzo" "compress-force=3Dlzo=
" "compress-force=3Dzlib:4" "compress-force=3Dzlib:4"
>
>         # on remount, if we only pass datacow after nodatacow was used it=
 will remain with nodatasum
> -       test_roundtrip_mount "nodatacow" "relatime,nodatasum,nodatacow,sp=
ace_cache,subvolid" "datacow,datasum" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datacow,d=
atasum" "$DEFAULT_OPTS"
>         # nodatacow disabled compression
> -       test_roundtrip_mount "compress-force" "relatime,compress-force=3D=
zlib:3,space_cache,subvolid" "nodatacow" "relatime,nodatasum,nodatacow,spac=
e_cache,subvolid"
> +       test_roundtrip_mount "compress-force" "compress-force=3Dzlib:3" "=
nodatacow" "nodatasum,nodatacow"
>
>         # nodatacow disabled both datacow and datasum, and datasum enable=
d datacow and datasum
> -       test_roundtrip_mount "nodatacow" "relatime,nodatasum,nodatacow,sp=
ace_cache,subvolid" "datasum" "relatime,space_cache,subvolid"
> -       test_roundtrip_mount "nodatasum" "relatime,nodatasum,space_cache,=
subvolid" "datasum" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "nodatacow" "nodatasum,nodatacow" "datasum" =
"$DEFAULT_OPTS"
> +       test_roundtrip_mount "nodatasum" "nodatasum" "datasum" "$DEFAULT_=
OPTS"
>
>         test_should_fail "discard=3Dinvalid"
> -       test_roundtrip_mount "discard" "relatime,discard,space_cache,subv=
olid" "discard=3Dsync" "relatime,discard,space_cache,subvolid"
> -       test_roundtrip_mount "discard=3Dasync" "relatime,discard=3Dasync,=
space_cache,subvolid" "discard=3Dsync" "relatime,discard,space_cache,subvol=
id"
> -       test_roundtrip_mount "discard=3Dsync" "relatime,discard,space_cac=
he,subvolid" "nodiscard" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "discard" "discard" "discard=3Dsync" "discar=
d"
> +       test_roundtrip_mount "discard=3Dasync" "discard=3Dasync" "discard=
=3Dsync" "discard"
> +       test_roundtrip_mount "discard=3Dsync" "discard" "nodiscard" "$DEF=
AULT_OPTS"
>
> -       test_roundtrip_mount "enospc_debug" "relatime,space_cache,enospc_=
debug,subvolid" "noenospc_debug" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "enospc_debug" "enospc_debug" "noenospc_debu=
g" "$DEFAULT_OPTS"
>
>         test_should_fail "fatal_errors=3Dpani"
>         # fatal_errors=3Dbug is the default
> -       test_roundtrip_mount "fatal_errors=3Dpanic" "relatime,space_cache=
,fatal_errors=3Dpanic,subvolid" "fatal_errors=3Dbug" "relatime,space_cache,=
subvolid"
> +       test_roundtrip_mount "fatal_errors=3Dpanic" "fatal_errors=3Dpanic=
" "fatal_errors=3Dbug" "$DEFAULT_OPTS"
>
> -       test_roundtrip_mount "flushoncommit" "relatime,flushoncommit,spac=
e_cache,subvolid" "noflushoncommit" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "flushoncommit" "flushoncommit" "noflushonco=
mmit" "$DEFAULT_OPTS"
>
>         # 2048 is the max_inline default value
> -       test_roundtrip_mount "max_inline=3D1024" "relatime,max_inline=3D1=
024,space_cache" "max_inline=3D2048" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "max_inline=3D1024" "max_inline=3D1024" "max=
_inline=3D2048" "$DEFAULT_OPTS"
>
> -       test_roundtrip_mount "metadata_ratio=3D0" "relatime,space_cache,s=
ubvolid" "metadata_ratio=3D10" "space_cache,metadata_ratio=3D10,subvolid"
> +       test_roundtrip_mount "metadata_ratio=3D0" "$DEFAULT_OPTS" "metada=
ta_ratio=3D10" "metadata_ratio=3D10"
>
>         # ssd_spread implies ssd, while nossd_spread only disables ssd_sp=
read
> -       test_roundtrip_mount "ssd_spread" "relatime,ssd_spread,space_cach=
e" "nossd" "relatime,nossd,space_cache,subvolid"
> -       test_roundtrip_mount "ssd" "relatime,ssd,space_cache" "nossd" "re=
latime,nossd,space_cache,subvolid"
> -       test_mount_opt "ssd" "relatime,ssd,space_cache"
> +       test_roundtrip_mount "ssd_spread" "ssd_spread" "nossd" "nossd"
> +       test_roundtrip_mount "ssd" "ssd" "nossd" "nossd"
> +       test_mount_opt "ssd" "ssd"
>
>         test_should_fail "thread_pool=3D-10"
>         test_should_fail "thread_pool=3D0"
> -       test_roundtrip_mount "thread_pool=3D10" "relatime,thread_pool=3D1=
0,space_cache" "thread_pool=3D50" "relatime,thread_pool=3D50,space_cache"
> +       test_roundtrip_mount "thread_pool=3D10" "thread_pool=3D10" "threa=
d_pool=3D50" "thread_pool=3D50"
>
> -       test_roundtrip_mount "notreelog" "relatime,notreelog,space_cache"=
 "treelog" "relatime,space_cache,subvolid"
> +       test_roundtrip_mount "notreelog" "notreelog" "treelog" "$DEFAULT_=
OPTS"
>  }
>
>  # real QA test starts here
>  _scratch_mkfs >/dev/null
>
> +# This test checks mount options, so having random MOUNT_OPTIONS set cou=
ld
> +# affect the results of a few of these tests.
> +MOUNT_OPTIONS=3D
> +
>  # create a subvolume that will be used later
>  _scratch_mount
> +
> +# We need to save the current default options so we can validate our cha=
nges
> +# from one mount option to the next one.
> +DEFAULT_OPTS=3D$(cat /proc/self/mounts | grep $SCRATCH_MNT | \
> +               $AWK_PROG '{ print $4 }')
> +
>  $BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/vol1" > /dev/null
>  touch "$SCRATCH_MNT/vol1/file.txt"
>  _scratch_unmount
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
