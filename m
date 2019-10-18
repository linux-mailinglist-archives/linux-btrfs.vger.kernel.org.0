Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5040DDC3AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 13:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409920AbfJRLLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 07:11:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:49909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406077AbfJRLLR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 07:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571397060;
        bh=A9adyev60G+8A3X1BLwGFRGlc6vfkkEkTOdMO7XkM/Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DvnENdNIp6VtKl1m8qiR3Bwwe7lwj16G97isTfaKz7k/gtRm5LewBoATOhUTbDw+b
         /V4GYjtCOkFZvSpP3to3o+5JgJkUnQsSUme/Y7qZy66POFh9+lsQIWQWB/rP10kVsl
         NV3yHOwDd3SRdobjxprItJiNrd4wIVjnxHj3oemE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4z6q-1hw5Dj2DmW-010sHq; Fri, 18
 Oct 2019 13:11:00 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: warn users about the possible dangers of
 check --repair
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, anand.jain@oracle.com,
        rbrown@suse.de,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191018094203.14147-1-jthumshirn@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <5a9c002d-2707-3487-0519-6457bbe35294@gmx.com>
Date:   Fri, 18 Oct 2019 19:10:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018094203.14147-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vhrUD/i3MXYnZdOz3YjkO7c+gQMRBzNmqpbZwC+qVxaQscKctej
 o6wFcJB31R25sLsGchI0o8RFGYgyNSjHgSZ0uCDkN6xUeIkh2Ymlytr7ONy+hy6F8X2OnGr
 5RoMM5C2xi+rImr9wfEWC9qPm9koOwnCOHcwPmKbIojR8E49pO98wNksPAYZHef1Y+CjJFi
 OC4dfcOkaimeF6ydlIYbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IOCzfuviH3U=:PXQLMyQw4ZzXRZQVveXefx
 fm4baUWbqVd52NIbLQ9nLdai87WGgA2sZ2tX7Gv5rUl3Xp3qFpn0F9sNC9SL+Tk6NcjAirIH/
 1UyUIGHXHgL8ci4jr44GM0R2n+eaCrqbXO6zZlixHiQbrb7RHqQIyqxaf8jKk0PuGJSWXUz12
 vBMspHvW/oPULRFxUO2f16nPrkw8qnlp7vTAOantLZLr1g1d/5eiLXDx45rCJDGltgvXXi/eH
 Ov75i5na4PICa+BdlNWFeY0ibv8dUaaM+i+34G4zhPk6DhjNk3VjVw+xVNJLdiCuHIhhtvYTC
 pd6lvDlya5tYzEhmNiov/31j4gaCxYamyp7g/aEKJaKKuL4B70UwggYmQJAZrivwZMb5WTLb5
 wHGXoAx/sfzYjXY4fuoH52DuNxbyc3E1embgufuiojV/C49h8FTzOgwBKgI3y3MIzNX283x3f
 C1+G/ZnHwSPIkMdv3STqZHbb/bUHo/42yCJdUAh+UvXEjxQf9eh4eewQKFl6C1tx71O26czBf
 rTvw7fl3RR9lX29VfFZR2RNgXkcLIHtIC3f7Sl7QwPGQaL2sxB8DccdpEWdPk4eUA7/9Ico51
 Ov0DFw2oeODt03i/iSfFheDilc8kPcbsehxq+zVmLFJY8igyFcxlQsmeohZEdASNXkh1lsUp3
 fnAO+Qrz51zmaraad5ttxA87XMfpAhbw3ckgTbxLwJm/cDjk+MzF1rXV/a9Vr8PqVfjeHEAVy
 fEO/DlQnl4vpfrbuuF1VS54bKVLoejBdOQnchIwDLG10wOI8+gN4WTfxON2D70Ig1emtTSVmM
 /+ygpodqz5hDUxz5nboOWr61MWsgtcAXiD0wqLw5iijpBxTUSZoJvn+K/7W33XSFmCketXyds
 pZpdefruEWPHgJ51Mg8cQ1GSNZRWR7tSXgPKhIWXaX2/23cG8CAD4zRhSJCVqxNkjIwYd58eF
 rMZlTIbI2bYO7ODDJHJ80MW1pOkxPrsHymYe5lu466aCv7Y3tyEv9GilUekq/ZWOSq7bASN7P
 JTct8cEV5V1SWYsrNNNdFmX2mt4pAHYGdNui3Drd0kuhX7cV/YnkVe+BnFSy8ssTZ6Dcunm0D
 R/NNfQtlJhoDAdjDIMQui9WVroiGRhioAVT3kJvznahQNk9NdBv6rTnn/pxZGJo670OWS0/FO
 lGMNDVPK6SApTo7q6AmKWdVNzI2+EyrhYwWBwTAt/anjswD5RQ2glpRUt4YFb2/0mDq6O0Y+l
 ay+D/d2BCZHgr6VE2jUO3eIFOw8wuRBuHKcmHYwgOObpNUGI/x5P9r+vzKN4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/18 =E4=B8=8B=E5=8D=885:42, Johannes Thumshirn wrote:
> The manual page of btrfsck clearly states 'btrfs check --repair' is a
> dangerous operation.
>
> Although this warning is in place users do not read the manual page and/=
or
> are used to the behaviour of fsck utilities which repair the filesystem,
> and thus potentially cause harm.
>
> Similar to 'btrfs balance' without any filters, add a warning and a
> countdown, so users can bail out before eventual corrupting the filesyst=
em
> more than it already is.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks good to me.

Although I really hope I can soon remove this confirm soon enough. :)

Reviewed-by: Qu wenruo <wqu@suse.com>

Thanks,
Qu
>
> ---
> Changes to v1:
> - Fix grammar mistakes in warning message
> - Skip delay with --force
> - Adjust tests to cope with btrfsck --repair --force
> ---
>  check/main.c                                       | 23 +++++++++++++++=
+------
>  tests/cli-tests/007-check-force/test.sh            |  2 --
>  tests/fsck-tests/013-extent-tree-rebuild/test.sh   |  2 +-
>  tests/fsck-tests/032-corrupted-qgroup/test.sh      |  2 +-
>  tests/fuzz-tests/003-multi-check-unmounted/test.sh |  2 +-
>  5 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index fd05430c1f51..1fecfc37c135 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9970,6 +9970,23 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>  		exit(1);
>  	}
>
> +	if (repair && !force) {
> +		int delay =3D 10;
> +		printf("WARNING:\n\n");
> +		printf("\tDo not use --repair unless you are advised to do so by a de=
veloper\n");
> +		printf("\tor an experienced user, and then only after having accepted=
 that no\n");
> +		printf("\tfsck can successfully repair all types of filesystem corrup=
tion. Eg.\n");
> +		printf("\tsome software or hardware bugs can fatally damage a volume.=
\n");
> +		printf("\tThe operation will start in %d seconds.\n", delay);
> +		printf("\tUse Ctrl-C to stop it.\n");
> +		while (delay) {
> +			printf("%2d", delay--);
> +			fflush(stdout);
> +			sleep(1);
> +		}
> +		printf("\nStarting repair.\n");
> +	}
> +
>  	/*
>  	 * experimental and dangerous
>  	 */
> @@ -9998,12 +10015,6 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>  			goto err_out;
>  		}
>  	} else {
> -		if (repair) {
> -			error("repair and --force is not yet supported");
> -			ret =3D 1;
> -			err |=3D !!ret;
> -			goto err_out;
> -		}
>  		if (ret < 0) {
>  			warning(
>  "cannot check mount status of %s, the filesystem could be mounted, cont=
inuing because of --force",
> diff --git a/tests/cli-tests/007-check-force/test.sh b/tests/cli-tests/0=
07-check-force/test.sh
> index 317b8cf42f83..6025b8545c52 100755
> --- a/tests/cli-tests/007-check-force/test.sh
> +++ b/tests/cli-tests/007-check-force/test.sh
> @@ -26,7 +26,5 @@ run_mustfail "checking mounted filesystem with --force=
 --repair" \
>  run_check_umount_test_dev
>  run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
>  run_check $SUDO_HELPER "$TOP/btrfs" check --force "$TEST_DEV"
> -run_mustfail "--force --repair on unmounted filesystem" \
> -	$SUDO_HELPER "$TOP/btrfs" check --force --repair "$TEST_DEV"
>
>  cleanup_loopdevs
> diff --git a/tests/fsck-tests/013-extent-tree-rebuild/test.sh b/tests/fs=
ck-tests/013-extent-tree-rebuild/test.sh
> index ac5a406a8b8a..33beb8bf55b4 100755
> --- a/tests/fsck-tests/013-extent-tree-rebuild/test.sh
> +++ b/tests/fsck-tests/013-extent-tree-rebuild/test.sh
> @@ -35,7 +35,7 @@ test_extent_tree_rebuild()
>
>  	$SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV" >& /dev/null && \
>  			_fail "btrfs check should detect failure"
> -	run_check $SUDO_HELPER "$TOP/btrfs" check --repair --init-extent-tree =
"$TEST_DEV"
> +	run_check $SUDO_HELPER "$TOP/btrfs" check --repair --force --init-exte=
nt-tree "$TEST_DEV"
>  	run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
>  }
>
> diff --git a/tests/fsck-tests/032-corrupted-qgroup/test.sh b/tests/fsck-=
tests/032-corrupted-qgroup/test.sh
> index 4bfa36013e81..91bbd51a4ebd 100755
> --- a/tests/fsck-tests/032-corrupted-qgroup/test.sh
> +++ b/tests/fsck-tests/032-corrupted-qgroup/test.sh
> @@ -13,7 +13,7 @@ check_image() {
>  		     "$TOP/btrfs" check "$1"
>  	# Above command can fail due to other bugs, so add extra check to
>  	# ensure we can fix qgroup without problems.
> -	run_check "$TOP/btrfs" check --repair "$1"
> +	run_check "$TOP/btrfs" check --repair --force "$1"
>  }
>
>  check_all_images
> diff --git a/tests/fuzz-tests/003-multi-check-unmounted/test.sh b/tests/=
fuzz-tests/003-multi-check-unmounted/test.sh
> index 3021c3a84968..176272e508d7 100755
> --- a/tests/fuzz-tests/003-multi-check-unmounted/test.sh
> +++ b/tests/fuzz-tests/003-multi-check-unmounted/test.sh
> @@ -18,7 +18,7 @@ check_image() {
>  	run_mayfail $TOP/btrfs check --init-extent-tree "$image"
>  	run_mayfail $TOP/btrfs check --check-data-csum "$image"
>  	run_mayfail $TOP/btrfs check --subvol-extents "$image"
> -	run_mayfail $TOP/btrfs check --repair "$image"
> +	run_mayfail $TOP/btrfs check --repair --force "$image"
>  }
>
>  check_all_images "$TEST_TOP/fuzz-tests/images"
>
