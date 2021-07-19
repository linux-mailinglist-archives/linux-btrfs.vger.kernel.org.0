Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17E3CD1D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 12:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbhGSJpA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 05:45:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:60359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235416AbhGSJo7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 05:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626690335;
        bh=c4cCzAHAWjxDvP0llz+KOBOj9in5gdSt5SiGphEW96Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=P8ImWHa706K0pGU1J8GyaRGTmNAAyUvmt7yoyozgoP5Li4CXdPusE1zsksZ4KX2Kb
         yAKtI5I3V5Hofw1ofcjomFlp5ilDhyYqOC5VQaj9VyfZxdJtF6lwVlyJhnD2jm5VHp
         eVEsG20WnZqs5haAnsHgGdEaVpDpBEZHzAnj88ys=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mf0BG-1lUhnQ0cKg-00gU6r; Mon, 19
 Jul 2021 12:25:34 +0200
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-test: add test case where one dir
 has two links
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210718125449.311815-1-wqu@suse.com>
 <20210718125449.311815-2-wqu@suse.com>
 <f32b89d5-a7f1-dfa4-d706-2eb96d98a004@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <da7653d0-5736-0058-145d-fc6ff641f2f2@gmx.com>
Date:   Mon, 19 Jul 2021 18:25:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f32b89d5-a7f1-dfa4-d706-2eb96d98a004@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xrQSIlIl/B09byYHUAOWQVFYLhUM6GrVSep4mHaY8tFZ5IzxEHP
 lRFwJ/J1VGuE+9ZJTGCG7S7vHKSEKAizUDq/ZsFM4xCeJK5Hoh7iDphvSoG9NzwgVbi0wGX
 pZqqNWbgkat4aevEgmpPx8rCE/2rjjXdcjxAijPpwNL/uCuYLjbONRoDknFW5fAXM3Gu7j9
 VXvDpIzruP7GH8QHDwqLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kb08kqxNc28=:+bZtec7pNYy+xQl3QkZPkh
 MVwr1wPk6TvaYGtExP5AGXXpa4bUput8Q9ZPcgyyVgydW+nAux3lTvc7/LEy2xWwMvCejskbf
 Chn7+pexfyp0m7XKdnc9Q6UXXa4AoOrjuTore/6jmE/ox+J0jgYe49dIvqqqvSDJVAHcos3oj
 cE4bD+T9XaD+B9kZ5TG1w/z35k9bdc1BwZLsLV6JZh1qMGtFNQsQtQjivmlF9GVpaCOp3cTt+
 SL4Pw7FXiQrIq9o38kAVRIRemfhq1I+526ShO6yRz+Ig/AFPgEJ5BlbIIhGGOHp8mFzmCHCMS
 Y3UhJjYe286kWhY9S0sYqCb1fl3XsF1Ch5MWGY8tLSn64kYKEDb/D7eyk9w7MNNbpsjKNgyvV
 s+zqIpxrjVc74kha+b1ZLJdjOJ2fEDQZ+Ko9qLhESqhsZYMItOXtjTiDOp0BHCr6vybQvHeSC
 nCuGsCx3inRA8GkYPshvdt99GGx5AnklCFCJg0Aqo+iJ4PQAZSZorpgDbtoJa4TlS8aisSASb
 SGK7O0/LGaB9SCmI9sTuuHWZolev5FOE1kDx6YKRSyzhQU91nEHCFUX0d4ynxoo73qAfE55D2
 92B90ffH326jLVOpxCQkzy/zn2DpzNgp3kXEys2Xcy72+v2/OfBg1J3pjMivzaSewNrpj3Vqf
 TpTYJdpkX6oYvn/w8B7/el057EXXLrRLSsXSzYrzkOcAa9mMma/VSba6JiXbEMu+1TPXpGn5W
 zhtC0cRKxdWQ1+APqUAMk/EC3PNwrM1dezmayrBT4gAKtFeuXJYNjiGbdBpB+AY4S4WyEjkv+
 rG54bmOBA8UcKXgF8IQmy0zxy7GEYS7ZKtaDwj5QTvdjIYfOVo0os0u0mOa7fllsDmGB6yHB6
 WSKSEjYHUvE4ufW8D96xYVck3UUuTpudwWvHzxtdIKvuTWKrudH83vggTVx0iQF5qcu2SHGf8
 JvZ3SsAhQ5Q0mBKLGoRYeckmgvnrErLrokgkogC27S6JGVChZ8JcmI1Y6yK73PwcI3xEGl35k
 nPnrPmU2YoaDSPhxAk0aNfzETNQO6TKbpOzGa/5d40WdP6mvXQgiNaTkjit6AG0XhP674xHSK
 u3paMdnu7R0ubq7FODppOKuxmAX7BP5oZPe2uPhcVs2BN9HFbo01GEUpg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/19 =E4=B8=8B=E5=8D=885:57, Anand Jain wrote:
> On 18/07/2021 20:54, Qu Wenruo wrote:
>> Make sure btrfs check can detect such problem.
>>
>> Right now we have no way to fix it yet.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
>
> Test case runs fine. Do you use any tool to create the crafted image?

As usual, just hard coded btrfs-corrupt-block to call btrfs_add_link()
for a directory.

Thus there isn't really a good tool to craft such image.

Thanks,
Qu
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Thanks, Anand
>
>> ---
>> =C2=A0 .../049-dir-hard-link/default.img.xz=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin 0 -> 1712 bytes
>> =C2=A0 tests/fsck-tests/049-dir-hard-link/test.sh=C2=A0=C2=A0=C2=A0 |=
=C2=A0 19 ++++++++++++++++++
>> =C2=A0 2 files changed, 19 insertions(+)
>> =C2=A0 create mode 100644 tests/fsck-tests/049-dir-hard-link/default.im=
g.xz
>> =C2=A0 create mode 100755 tests/fsck-tests/049-dir-hard-link/test.sh
>>
>> diff --git a/tests/fsck-tests/049-dir-hard-link/default.img.xz
>> b/tests/fsck-tests/049-dir-hard-link/default.img.xz
>> new file mode 100644
>> index
>> 0000000000000000000000000000000000000000..fd9971acae78975f5263da022feea=
39e34b45139
>>
>> GIT binary patch
>> literal 1712
>> zcmV;h22c6@H+ooF000E$*0e?f03iV!0000G&sfah3;zaiT>wRyj;C3^v%$$4d1lq4
>> zhDvnFHzu^a0%EHA+fjUfU^d-f8FD79nuh5qo92GkFUET_5R5Y~d)afdfW4sb2eW+N
>> z(-N9N;@zX$?eR^yQlFZnSsfYzwplHEI#}i{O3&^g-%*#*J}6=3D@&Mr933Z)S+DYvtb
>> z5k;9l__I-yJ`AS&v0F{j8)>U_CUcN9uhMMZ>r0aFa$nT3PO%||kR#<>`b&X;^jZx!
>> z?T$2In^=3DHo4dSN<1OU-V{`iJKl4iT0qZ?qN2!NSUwLkY=3D{)k)$fv5z~^N4kqFTY0A
>> zY^ShS`wE?^@sQEzTB{J`c&Co>am(cbBo?iCTX8yDg2XD@%iu+8T>Rs=3DOS3N#=3D)3bd
>> z$%Q$2o4Jw~)_B}yv$C$3d8z@>PGT?pn~}TQM)H=3D}8OiIM$T%7bnT!rm9e8Kj*IY>i
>> zRi|m%s0@W^`QQLHd#kk%hsBhG;@X+L^icR9?z+_VJJC<foGA3E&6VL0{A;3%cJ=3D=3D0
>> zQ+LXY%FpCSU)dp6X$Db0^2j&;AImxC;Iy5{kd&j-sreBlGe;CO#@LBXsWNs-s4G^5
>> zkMnbl8qo_y<Q)yll@uqpxB_Bx^j<x0L&1{_?eTSfuoc&?{=3DND?bOY}m<67e4t51xj
>> z>$Xiwp#%2bqwq<I)rOyv*`#zeM<Er2k_h=3Dl{vxz1wjGBxV(;KGg9_2$*Kfm|7ZEAA
>> z=3D#taOkp3nuN;q+AP%$EA-qgk2$~WCSuo1Go&dnEkC8r$ZFr)emrzMJYyvjZRQJZ89
>> zcWLi>gAl7R=3Db$=3DTKgrNtsjTs>%c()OaRth)4EnpQ5JVZ^(KTPzrUX{p9;-ybSWq%f
>> z+h=3DIPq3LWP%?;tzwce-qMY!>K!A<EL7J&#QUT?J|X~kIJH7Y_FhS^-tciImm#D&ui
>> zMz;h<iYbcZa};e;dL=3DNp=3D)rTzy50l2>5@FkSm-}C%Z0i|p;ur0NT-IX6}s8Rm!mfP
>> zPXw<w=3D}9Bq{+=3DJ`=3DfD_;I&jaRg6LR`djeb}vAS|IF)+k`T^~r|BTi*ybSenXmZ1I=
x
>> zlA4$_;+N(C3J7h=3D)1T;tjo|#zD%6%Y(CGjKm&49ls!JyP&^_~FO;k^HQ!|sIrEsM5
>> zmu;FGGjE9B-8~BN+PBwW;ax;BdCareelj76adsW5H3ZV!_O4_e4!dny=3DgWye6eznx
>> z*02QRiZ5oikY7EFi&f=3D|OkHl4;@~lbD#W-Ff>?{gkFl<_oY!Dd@ggcd1EGiS(3Q(7
>> zs81W|!q{6Sla<jssW?Bhc2AS+ydwD%2;1kqUB^-#h>!9bbNKzzP+95lMs6qCdis3(
>> zxIT1wv2PKhAZso_!f!HtAShXA6eHuXWK0`PVh5TX(wgYr!l9e|jW&M_)<e3^X<w4M
>> zY_P_kf=3D8+|nGi>DRcZBVfPyNr$65P*t{sM-vjL`XqP~HHY0FV{L*~3B=3DdzP+MOU1@
>> zRYWfI#vm2^g>N$aie=3Da^L(xQu@pRjw4DXt%wU7m~@-}@QvcEN^UEJ@e6Xm8m=3D^ZRq
>> z)cUF@zR;E|i)7w`)u*a&WXIzpygnt3`|17G^sPOyW0?V~!r7SasXdubQAKKtR^|uf
>> z4;4WRHG()C2~#M*GC^l@k>w3^5M{@6>W%dgSU>Zqn+vNd*2f><3(CVuqAnX=3D(Zu(G
>> zF(j4`;!MKu6~PVFgQz$=3Djt#O~3U4TtOFg;!(X?=3DT=3DjRzhT3yzSXD>1GA8~FpzJVn=
t
>> zUmIYu;aQe?QMT(4UkP16u@m}5@AX6}DPA>a!#dt3qbX_CfS5)G-*MI@B#;(Ap1`{;
>> z3VE<Z0{u?EC{{mUj$DSQ|Lv6DL`62yckCVEF6WgD4l%e+sw}4(qMD4Y=3DX-!VdYJo{
>> zKb+fu*f8Tk!0fZzzcR|8Tl0H%R#9A&@3h+`YzekzO#*X*=3D^j()i-pyn&%m-Ln_2H!
>> z&+nI1M9}8)2($&79_I@LdA5md{Ue@-$tE1%0OeJZ{UaXg=3D~jG>C#T>wd^;QzL0K(}
>> z6tjZD62IVa<@fK+TssaPJ~B{H`R=3DbR5r$9ZK8P2Nah9n(3W~$(5piy!QO^Al)?l4Q
>> z`5~x}6Pex_Yr=3D?Q*&mMGj7l@I6&y+9_H<1QmoCJTx0Y6JJmE9n=3D>iO#ToI;6F9dI)
>> z!d^0KXk;SSyDf^@yN)Q-8qxAM^Z)=3DciSQA~y}h;o0gMfR7ytk~fZMIH#Ao{g00000
>> G1X)_MbXXt&
>>
>> literal 0
>> HcmV?d00001
>>
>> diff --git a/tests/fsck-tests/049-dir-hard-link/test.sh
>> b/tests/fsck-tests/049-dir-hard-link/test.sh
>> new file mode 100755
>> index 000000000000..992ad638bd47
>> --- /dev/null
>> +++ b/tests/fsck-tests/049-dir-hard-link/test.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/bash
>> +#
>> +# Verify that check can detect overlapped dir with 2 links
>> +#
>> +# There is a report that btrfs-check doesn't report dir with 2 links a=
s
>> +# error, and only get caught by tree-checker.
>> +#
>> +# Make sure btrfs check can at least detect such error
>> +
>> +source "$TEST_TOP/common"
>> +
>> +check_prereq btrfs
>> +
>> +check_image() {
>> +=C2=A0=C2=A0=C2=A0 run_mustfail "dir with 2 links not detected" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$TOP/btrfs" check "$1"
>> +}
>> +
>> +check_all_images
>>
>
