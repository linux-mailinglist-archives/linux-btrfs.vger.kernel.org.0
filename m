Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D00793235
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 00:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjIEW6J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 18:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIEW6J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 18:58:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394ACEB
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1693954679; x=1694559479; i=quwenruo.btrfs@gmx.com;
 bh=IgQL+/+1sdBOsdSTzUh6R1Vh9b6rGuCib1Y9li3VIkg=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=Us1Yt9uiaaUzuhBRWujfTGh5bq6Pc5fDCXYmgHHHaQ9NLDVDFyyflvkZxIdgYSbsJASbhjQ
 NOMnWdbNdhbSQvohCd1VKsQ98tP/I9POq45ufswVD9GWWrlQAGXPBfQDuEHH3+f8r2ek2tnVq
 JIlJIKG6WaJe4YsoIQf7yZyB9lRnSk1c7weFgEQu6oBODS9014MqykIlklv5G910MXaB/8pha
 JdNxLDLhLt9T/9WlCgndZ7GV5sv2bJAD0zEVH/x6Rc7L4as7Vnrty4HsjEMH/t4mzCqk1vlEE
 WLilhX2crtLmp/VMGQrogJlLWNnCKONAjYVITj6qpNgsf79dzO9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1ML9yc-1qLZsS17Te-00IDkK; Wed, 06
 Sep 2023 00:57:59 +0200
Message-ID: <fe4c041b-e7a3-46ee-97fc-6ead9b2e2875@gmx.com>
Date:   Wed, 6 Sep 2023 06:57:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: add extent buffer leak detection to make
 test
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1693945163.git.josef@toxicpanda.com>
 <4df1b25365287e0fa3e7b4c8d1400ad5d576d992.1693945163.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <4df1b25365287e0fa3e7b4c8d1400ad5d576d992.1693945163.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G0NBcRcsPybNkGyqBS0GCTydFDVTZzD31Z7GXaPm+0xDSw8tI62
 dPAs7bkLOcDkoEdrBg3aLYBJk7ttEI3d9REwhoqxmmwwU+kM7943A8qBncR3nl94pO1KUFv
 fw8jRtvbH2tu3nJztK/S9N8TlxCfMUU89afd2cVO3AtVJWhXqjI518shH7mwHgwSscAWCac
 9x+gDSvOdSk3ZYHNAoNQw==
UI-OutboundReport: notjunk:1;M01:P0:cQiMqMNmhNw=;5jAdl6TDjTUyONANtqE6WoeFVh1
 BTkb7G4VgnbImGeGOdo2Rxx+OIjE4zwlGLD7cc8C2SWmITeOdQksJq/X9Z4j2WKsHAjgjdvg/
 gd+VTQBJGmDyv1RbvZSFx+lIlweL9avrEymsTyQYJpI2M74tUwGSIa5TZ5SGg1EmIqdiydAQl
 FiBKEF++y4mlW2wP9vbS+CK0NOwsvqhrcU6Dqgd4Q/g83RPKJrtdgMBkrRIEedfk2iFpJyosf
 n5635jwMuSjQoj7Nq/vxiFf/rUMPsvAERAWJcC7qT1f7DDGvllBh60ikJVY5HmNtt3+TLsexz
 RiJV9pgw/OW76QTDb+8a2fOge71f4g2R7/7Dz9BAPlsAtLdqGdMtWHswIREKEqmohQN6hXi6C
 UN3954uDYeeNYHA2xsI3JxdASEzjCNIAFApk2ZnajGhA5YBk8U9+aMd98/2mUA9NqiE5gwWgN
 d5OQVKSpKzw9v48MA0J2gLTfwepn6iOPaxg2bZB6WBCZOp+lB9tRcVWx3SeX9fpsKDjI+G9vn
 5IOwXq1oW4Ic+9knOkrluy3Czav6NcMU3hZgj6QHQBWxF1wO6qUsPUBRvTke2wEOekl002KSj
 PUWWdFs6z17m56TDMaIqSU6WAHIW4YGIomD5V39bDanyKMzbZGDzNPH1gU2UQ/loXozP8G9Wu
 4XrLrUTKdFbjAHu93VlIuthg9q7QJ8ABvJl+Vqwl9J7EJPYZUGzG2x5aBufdffLwDyBsdszjv
 YHpg2gpgMoMnwhDjRKRfEDWFWGo2ZTSzhd58W9BWFevbdulth8H3vLgj9SsMzKbVrz8eF4bE2
 LzvYX5Wr7Teh9Ku06M6cFT9mvaMAR9e1M8g6Ac5XyR6Zqcc7qw52b6Ax87kikMFaEVwOBgq7a
 9Stnd7iCQlT0CyCfK3v1KVQ1QtWaw5njlTrUCVbE0F/2Fb6m41XlGqJDgwWj0Gy35KR3ifnOZ
 LiwoFCkN5RMh4ya8yLMVXLxUcbk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/9/6 04:21, Josef Bacik wrote:
> I introduced a regression where we were leaking extent buffers, and this
> resulted in the CI failing because we were spewing these errors.
>
> Instead of waiting for fstests to catch my mistakes, check every command
> output for leak messages, and fail the test if we detect any of these
> messages.  I've made this generic enough that we could check for other
> debug messages in the future.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Another solution is to make debug build of btrfs-progs more noisy when
eb leak is detected.

Instead of a graceful exit (which is suitable for release build), a
noisy BUG_ON()/ASSERT() would definitely catch our attention, and
requires less work in the test framework.

Thanks,
Qu

> ---
>   tests/common | 108 +++++++++++++++++++++++++++++----------------------
>   1 file changed, 61 insertions(+), 47 deletions(-)
>
> diff --git a/tests/common b/tests/common
> index 602a4122..607ad747 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -160,6 +160,18 @@ _is_target_command()
>   	return 1
>   }
>
> +# Check to see if there's any debug messages that may mean we have a pr=
oblem.
> +_check_output()
> +{
> +	local results=3D"$1"
> +
> +	if grep -q "extent buffer leak" "$results"; then
> +		_fail "extent buffer leak reported"
> +		return 1
> +	fi
> +	return 0
> +}
> +
>   # Expanding extra commands/options for current command string
>   # This function is responsible for inserting the following things:
>   # - @INSTRUMENT before 'btrfs'  commands
> @@ -206,6 +218,48 @@ expand_command()
>   	done
>   }
>
> +# This is the helper for the run_check variants.
> +# The first argument is the run_check type
> +# The second argument is the run_check type that will get logged to tty
> +# The third argument is wether we want the output echo'ed
> +# The rest of the arguments are the command
> +_run_check()
> +{
> +	local header_type
> +	local test_log_type
> +	local do_stdout
> +	local tmp_output
> +
> +	run_type=3D"$1"
> +	shift
> +
> +	test_log_type=3D"$1"
> +	shift
> +
> +	do_stdout=3D"$1"
> +	shift
> +
> +	tmp_output=3D$(mktemp --tmpdir btrfs-progs-leak-detect.XXXXXX)
> +
> +	expand_command "$@"
> +	echo "=3D=3D=3D=3D=3D=3D RUN $run_type ${cmd_array[@]}" >> "$RESULTS" =
2>&1
> +	if [[ $TEST_LOG =3D~ tty ]]; then echo "$test_log_type: ${cmd_array[@]=
}" \
> +		> /dev/tty; fi
> +	"${cmd_array[@]}" > "$tmp_output" 2>&1
> +	ret=3D$?
> +
> +	cat "$tmp_output" >> "$RESULTS"
> +	[ "$do_stdout" =3D true ] && cat "$tmp_output"
> +
> +	if ! _check_output "$tmp_output"; then
> +		_fail "bad output"
> +		rm "$tmp_output"
> +		return 1
> +	fi
> +	rm "$tmp_output"
> +	return "$ret"
> +}
> +
>   # Argument passing magic:
>   # the command passed to run_* helpers is inspected, if there's 'btrfs =
command'
>   # found and there are defined additional arguments, they're inserted j=
ust after
> @@ -216,11 +270,7 @@ expand_command()
>
>   run_check()
>   {
> -	expand_command "$@"
> -	echo "=3D=3D=3D=3D=3D=3D RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>&1
> -	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD: ${cmd_array[@]}" > /dev/t=
ty; fi
> -
> -	"${cmd_array[@]}" >> "$RESULTS" 2>&1 || _fail "failed: ${cmd_array[@]}=
"
> +	_run_check "CHECK" "CMD" "false" "$@" || _fail "failed: ${cmd_array[@]=
}"
>   }
>
>   # same as run_check but the stderr+stdout output is duplicated on stdo=
ut and
> @@ -230,12 +280,8 @@ run_check()
>   #	filter the output, as INSTRUMENT can easily pollute the output.
>   run_check_stdout()
>   {
> -	expand_command "$@"
> -	echo "=3D=3D=3D=3D=3D=3D RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>&1
> -	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD(stdout): ${cmd_array[@]}" =
\
> -		> /dev/tty; fi
> -	"${cmd_array[@]}" 2>&1 | tee -a "$RESULTS"
> -	if [ ${PIPESTATUS[0]} -ne 0 ]; then
> +	_run_check "CHECK" "CMD(stdout)" "true" "$@"
> +	if [ $? -ne 0 ]; then
>   		_fail "failed: $@"
>   	fi
>   }
> @@ -245,11 +291,7 @@ run_check_stdout()
>   # output is logged
>   run_mayfail()
>   {
> -	expand_command "$@"
> -	echo "=3D=3D=3D=3D=3D=3D RUN MAYFAIL ${cmd_array[@]}" >> "$RESULTS" 2>=
&1
> -	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD(mayfail): ${cmd_array[@]}"=
 \
> -		> /dev/tty; fi
> -	"${cmd_array[@]}" >> "$RESULTS" 2>&1
> +	_run_check "MAYFAIL" "CMD(mayfail)" "false" "$@"
>   	ret=3D$?
>   	if [ $ret !=3D 0 ]; then
>   		echo "failed (ignored, ret=3D$ret): $@" >> "$RESULTS"
> @@ -271,19 +313,8 @@ run_mayfail()
>   # store the output to a variable for further processing.
>   run_mayfail_stdout()
>   {
> -	tmp_output=3D$(mktemp --tmpdir btrfs-progs-mayfail-stdout.XXXXXX)
> -
> -	expand_command "$@"
> -	echo "=3D=3D=3D=3D=3D=3D RUN MAYFAIL ${cmd_array[@]}" >> "$RESULTS" 2>=
&1
> -	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD(mayfail): ${cmd_array[@]}"=
 \
> -		> /dev/tty; fi
> -	"${cmd_array[@]}" 2>&1 > "$tmp_output"
> +	_run_check "MAYFAIL" "CMD(mayfail)" "true" "$@"
>   	ret=3D$?
> -
> -	cat "$tmp_output" >> "$RESULTS"
> -	cat "$tmp_output"
> -	rm -- "$tmp_output"
> -
>   	if [ "$ret" !=3D 0 ]; then
>   		echo "failed (ignored, ret=3D$ret): $@" >> "$RESULTS"
>   		if [ "$ret" =3D=3D 139 ]; then
> @@ -312,12 +343,7 @@ run_mustfail()
>   		exit 1
>   	fi
>
> -
> -	expand_command "$@"
> -	echo "=3D=3D=3D=3D=3D=3D RUN MUSTFAIL ${cmd_array[@]}" >> "$RESULTS" 2=
>&1
> -	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD(mustfail): ${cmd_array[@]}=
" \
> -		> /dev/tty; fi
> -	"${cmd_array[@]}" >> "$RESULTS" 2>&1
> +	_run_check "MUSTFAIL" "CMD(mustfail)" "false" "$@"
>   	if [ $? !=3D 0 ]; then
>   		echo "failed (expected): $@" >> "$RESULTS"
>   		return 0
> @@ -337,9 +363,6 @@ run_mustfail_stdout()
>   {
>   	local msg
>   	local ret
> -	local tmp_output
> -
> -	tmp_output=3D$(mktemp --tmpdir btrfs-progs-mustfail-stdout.XXXXXX)
>
>   	msg=3D"$1"
>   	shift
> @@ -349,17 +372,8 @@ run_mustfail_stdout()
>   		exit 1
>   	fi
>
> -	expand_command "$@"
> -	echo "=3D=3D=3D=3D=3D=3D RUN MUSTFAIL ${cmd_array[@]}" >> "$RESULTS" 2=
>&1
> -	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD(mustfail): ${cmd_array[@]}=
" \
> -		> /dev/tty; fi
> -	"${cmd_array[@]}" 2>&1 > "$tmp_output"
> +	_run_check "MUSTFAIL" "CMD(mustfail)" "true" "$@"
>   	ret=3D$?
> -
> -	cat "$tmp_output" >> "$RESULTS"
> -	cat "$tmp_output"
> -	rm "$tmp_output"
> -
>   	if [ "$ret" !=3D 0 ]; then
>   		echo "failed (expected): $@" >> "$RESULTS"
>   		return 0
