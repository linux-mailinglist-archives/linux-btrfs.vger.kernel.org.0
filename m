Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFACD19E1C0
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 02:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDDAA2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 20:00:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:42347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgDDAA1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 20:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585958421;
        bh=4nOYzJrFffZXbyD41fmGsnhqDb86+FUdN+ZutZ7tuBw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=TkTnID4QX1VnraKGOED0IQsXrm/slmJ9ag3VL/ywb0N1lvfZJl1RJaDQdLiv32Bis
         KM7R2SixZD8BlXBXpqvR/Gi/OavYJMe9WEDP2iP2vm3uhpyoNPuK1YIQcDuqRuoHAz
         BBSaWSVCXSBA4+ywPqQeUZqa/8A2OYLXAfAjGpQY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mi2Jn-1ipKLN3iWv-00e2WN; Sat, 04
 Apr 2020 02:00:21 +0200
Subject: Re: [PATCH] btrfs-progs: tests: Introduce expand_command() to inject
 aruguments more accurately
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200330070232.50146-1-wqu@suse.com>
 <20200403172016.GI5920@twin.jikos.cz>
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
Message-ID: <f297d7b0-d627-f4ca-920e-6a2cd4073970@gmx.com>
Date:   Sat, 4 Apr 2020 08:00:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403172016.GI5920@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UbdV3TRT5gcEd6PBOHTfeOWbAZvJNIfdG"
X-Provags-ID: V03:K1:JQkYXX3sgQQo1fo2Nd/LGQqwt362HcszQktnz+eU7RDSkyx+v6T
 cHdsQj66Wp8FVb+DW4cBwQ+3Vvh78GAWOn2gnga1ogIj4Gd9Rumak/0HPIhl/iI8ZirSYlZ
 zeebebMf0xJxnK5FXXSaezXVDKaStFEAsNkC/FHIAACzqOpZF4rdqZwuQUwcAWs/axaakos
 4pAPvCZKwsvsk0+0egpEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjLT0SaAhqw=:coMcFGX231uAGvgJf+H8na
 PSmuEPd0XdC3wfNpBUp/MgvcwzAZaKp9ZyOG0z11nzRgtkk3xpRXOQLVbVQrUPWlMHjcqOxag
 k31YqTn4g9jPSHtCil+m9OcCWVQfCLuB4b1AHK7DkaJ99arAr4yPcvKJMHhtbegeJsGcPnNNQ
 FmgcoqLVzWcJqnrd00oR0X0UWibvntNUQq+iQ48XqF3X3uTy0ZM9410ycLTUbMI3rnwFvgfIC
 zRvJbVO2ojlsxba9Rhn7ygQ3V3+bBuC2ObngGx1WH9Nj4FJwgcBiTlrYF/0HA64skv5/ADEpY
 /7ErC367MDa3yDSU7kLDAzsLyowAYeiuYoJxKMxBXCFUe7GwK1+9XDIiBW+9GKV9MaQ9bRBJZ
 MuJKBplM6PyEvbg9tod+5Mp/9olXjqP3BuoQMvb8bFk8h7rbkaYbgFB0YduPq+bKJbh0p9UlQ
 +ZuApa3x0NXvRg1PJXOQMZhpR3ZpNSBWGaFhflgEpizqIpHMoAkYno1IKKPoaI/jj7d7nt1Q0
 3IuWCCoXYv0bPuWEWC1Lxk0JazqAqLchcB1bTUHhLFueUYPLkucJVWwWUazE+ij38URvOxyV+
 EWJiwWcopsF/0TIspU6T5ud2x+QDd3KJ4CXa71Iqhj9WB/+7b00r7AVZfZFr8YeH1U0OIa5g9
 e3nS86GDUwgIH0IfKnsAj0IbO3gSqO8inIFnRdZKsGuQQedjYacjYWIVIftpK7/MEG7SfzLWi
 FUEEzn9CnxKmxveaxgNLnnukFsP4xckIdzeWE/J5TvjBMeF7OB1o3mI6ZaDVgM1jEq48VZm84
 8APISr1LO1NXJsubLlCph6qQLLJpif/WdbopvohcHgyxOdDu3ENlbEQjW/fRx9nh0lmU0vB/Z
 +I8YyQaCzev/x0S6VZUgoQsm8TYovXd2xo1FKwsUZeHzAeYKKBhlAsLeQaXkpiObFjAQgMN0p
 ToBDnGL+5+zTFvMqRkDf8n/ULZZvUNWdYTd6MCyuSx+U3Xm+XGM7Xvpetrl6IfOZeaJwsruoP
 PKpZwcPwe7sZK25bc8E+nRytrcUae7Xcf6LwAJMnisdW0l4haCD3dFknX0Bw1b0mwBppN/jix
 /Bl22upGNo1mEip80JtXRrL81xYfMnbci6D+UwR79hJVV/pzvQPP8ovlMo+8VT6qd7JrNjNkZ
 5R4kCyliilPTZepnWjWJIyxj0M+cDbwxKDZV5FqL7DFv494m8aKGrNTVIdLT//kdnrsm+12rB
 6t2lc1vvZLxzCEr0m
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UbdV3TRT5gcEd6PBOHTfeOWbAZvJNIfdG
Content-Type: multipart/mixed; boundary="rYspbi35bkGw6TAexy4kWIevDqXVNa5ao"

--rYspbi35bkGw6TAexy4kWIevDqXVNa5ao
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/4 =E4=B8=8A=E5=8D=881:20, David Sterba wrote:
> On Mon, Mar 30, 2020 at 03:02:32PM +0800, Qu Wenruo wrote:
>> +# Temporary command array for building real command
>> +declare -a cmd_array
>=20
> This gets declared only once when the script is sourced but there are
> numerous calls to 'unset cmd_array'. How does this interact?
>=20
> The functions are called in the same shell level so this will unset and=

> destroy the cmd_array, so it can't work after first use of eg.
> run_check. So there's some shell magic because this seems to work.

Exactly what I tested before crafting the patch.

# declare -a tmp
# tmp+=3D('test')
# unset tmp
# tmp+=3D('test2')
# echo ${tmp[@]}

And it worked, thus you see the patch.
>=20
>> +expand_command()
>> +{
>> +	local command_index
>> +	local ins
>> +	local spec
>> +
>> +	ins=3D$(_get_spec_ins "$@")
>> +	spec=3D$(($ins-1))
>> +	spec=3D$(_cmd_spec "${@:$spec}")
>> +
>> +	if [ "$1" =3D 'root_helper' ] && _is_target_command "$2" ; then
>> +		command_index=3D2
>> +	elif _is_target_command "$1"  ; then
>> +		command_index=3D1
>> +	else
>> +		# Since we iterate from offset 1, this never get hit,
>> +		# thus we won't insert $INSTRUMENT
>> +		command_index=3D0
>> +	fi
>> +
>> +	for ((i =3D 1; i <=3D $#; i++ )); do
>> +		if [ $i -eq $command_index -a ! -z "$INSTRUMENT" ]; then
>> +			cmd_array+=3D("$INSTRUMENT")
>=20
> This inserts the contents of INSTRUMENT as one value, that won't work
> eg. for INSTRUMENT=3D'valgrind --tool=3Dmemcheck' or any extra paramete=
rs
> passed to valgrind or whatever other tool we'd like to use.

That means the INSTRUMENT must be space split, no way to pass anything
not split by space.

Despite that, I'm pretty OK to change it.

>=20
>> +		fi
>> +		if [ $i -eq $ins -a ! -z "$spec" ]; then
>> +			cmd_array+=3D("$spec")
>> +		fi
>> +		cmd_array+=3D("${!i}")
>> +
>> +	done
>> +}
>> +
>>  # Argument passing magic:
>>  # the command passed to run_* helpers is inspected, if there's 'btrfs=
 command'
>>  # found and there are defined additional arguments, they're inserted =
just after
>> @@ -145,49 +202,28 @@ _cmd_spec()
>> =20
>>  run_check()
>>  {
>> -	local spec
>> -	local ins
>> +	expand_command "$@"
>=20
> The cmd_array should be reset before it's used to build a new command,
> not after.

Is there any difference? Or unset it before just makes it cleaner?

Thanks,
Qu

> =20
>> +	echo "=3D=3D=3D=3D=3D=3D RUN CHECK ${cmd_array[@]}" >> "$RESULTS" 2>=
&1
>> +	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD: ${cmd_array[@]}" > /dev=
/tty; fi
>> =20
>> -	ins=3D$(_get_spec_ins "$@")
>> -	spec=3D$(($ins-1))
>> -	spec=3D$(_cmd_spec "${@:$spec}")
>> -	set -- "${@:1:$(($ins-1))}" $spec "${@: $ins}"
>> -	echo "=3D=3D=3D=3D=3D=3D RUN CHECK $@" >> "$RESULTS" 2>&1
>> -	if [[ $TEST_LOG =3D~ tty ]]; then echo "CMD: $@" > /dev/tty; fi
>> -
>> -	# If the command is `root_helper` or mount/umount, don't call INSTRU=
MENT
>> -	# as most profiling tool like valgrind can't handle setuid/setgid/se=
tcap
>> -	# which mount normally has.
>> -	# And since mount/umount is only called with run_check(), we don't n=
eed
>> -	# to do the same check on other run_*() functions.
>> -	if [ "$1" =3D 'root_helper' -o "$1" =3D 'mount' -o "$1" =3D 'umount'=
 ]; then
>> -		"$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
>> -	else
>> -		$INSTRUMENT "$@" >> "$RESULTS" 2>&1 || _fail "failed: $@"
>> -	fi
>> +	"${cmd_array[@]}" >> "$RESULTS" 2>&1 || _fail "failed: ${cmd_array[@=
]}"
>> +	unset cmd_array=20


--rYspbi35bkGw6TAexy4kWIevDqXVNa5ao--

--UbdV3TRT5gcEd6PBOHTfeOWbAZvJNIfdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6HzhEACgkQwj2R86El
/qhfkggAjYILiPFATYIBqKxBBnKDu2IBoTMdGL0BIQaKvfbZ9KaJ6lAsI23BFBic
of5gUCSRsndu6NW6DbEl/ygNh5P1gxN/uF4Iwu/ldui+JwF0zS72edPlC8LIISp1
YtylHgY0UGHs39WARf0h/XiphExL/7dbWDKArke8ouA1Sakv3VfDMS0fj1x78bPR
2B50lY+7YNnXy4DKZ3lOzLdxxxUADhJxPkRKlVBu+dg4+N1Vtf1ByMfFharkdnGo
2gnWxggXnR/drtGdilRMhdKPM0/ZJAy1+ln+ZN5DUe2scbxodYrEQJU1+oYIgL9Q
/YxGvK0UomeHLC7MspHicEOWQfP0LA==
=GZt8
-----END PGP SIGNATURE-----

--UbdV3TRT5gcEd6PBOHTfeOWbAZvJNIfdG--
