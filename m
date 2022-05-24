Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8EA532B30
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbiEXNVO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 09:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237785AbiEXNVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 09:21:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2C8101F1;
        Tue, 24 May 2022 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653398468;
        bh=eoKzqDHPboxuQqq4FrwbNRBk6YaO0GfdfbJ6yo7GpA8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dR/A3KBvRz0DlWYYFprt8hPsYy29ehp9M+aHAqObzyWXjp9g+KBYgSDkvLjkaE9ki
         f0nk43/ubZY18trMFlnP2HjE9YQ3ailyySoy1xRc6PzyowvsAOlMIhpAtizZ1/kyHr
         MFG8unc84SqwxKw7Iau3orFGIMo2m+wUWvouyh1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1oMIo60O8f-00XLwY; Tue, 24
 May 2022 15:21:07 +0200
Message-ID: <c8bade74-d12d-57c7-3a50-3ecf061a7981@gmx.com>
Date:   Tue, 24 May 2022 21:21:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/9] btrfs/140: use common read repair helpers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20220524071838.715013-1-hch@lst.de>
 <20220524071838.715013-3-hch@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220524071838.715013-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k7YITjNT6jfRpYn8G2vN2elYrcc7NRT2II1ONujDwnmE53yfDX2
 n5mmyJgRvqDVdNzvoWTIag2v2qMZvpSHXhNXAUaSZw0DdNdj91taCS6oF4+LEGvqTlSDQ9J
 VCH5cByNrWl4V91wbKib3qi1aHFNkxjgWgeI1lsSFr6N19kiMBCpur9uvVdX4ou+FHDs5qE
 5fkhAfy1MpNADyEe01hjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9V6qXJ24vto=:2B5tD0lsNLvwuTDkalgx0M
 014iRuY3/17KtlKckGG1zNMhgqDUsxemHlrj6ZoKnmTbrHxU/XzD1nEyz1/dXCrcmvG6ZAemI
 aSgopxOFKgBhjbZ5CwwmSL7hm2Ysk0jXPOcZ4fQaR66S1cHnKaPOPsKkQDPd9577/z8G23HAQ
 uQvUyzltHArdlAmMODroB70gjc82982mXJqMqT8eGTIz5Ab/XRCLADzIDc29btwzPYpNXKxhp
 7QRIid5OmE553SOvLkwHZ1lvoM0GY9KWBRxTVXMr4Wso8cnelZTLzwzJ+siRgwNeNA4pVNnsE
 heB/M4o5lWAijTPbIX5c59SUX4n7r/g8z/E2qL2tgPoL8TfiQpuP2ZP/q8NvUILPy7jhhtQzR
 kspsrES9mZ3Ca6KQO87J613pOYqRrEloL8KtPF0+2dTmE+wyCWTTXA9GABuKA9GHhAsjShhK5
 7ec3dMIpfMzYB0zyaks1ZKNz1eYQKnEV0B4siocO6NwIoHYM0VBJnnpZuNYkdpy2RmsdUcqVf
 Q8GuzdwmMrBuBPocido9eXJpsOv/VQ/QcBd6yCLmGFDTty6rxIfkt1BjcayS0uU2XMEhhbTZI
 362Kbbf3J/Btz5LXyucbxWL+p8MASc0KpXkRAylRfnUqFJOKTgBL3F3qzlSv0uidw1EJD6UnC
 BNckJDStFGbpXx3tCoCM/RdZgIsRmJSuq7SbKFEZLgqHJVt34EHhx3usntM6XX6DKEC+Zd5w5
 DaC0+4mU21htdu0aA/7uvfgbwNm9kJK4lKrK4uRNMxcWCoZfPsHH1t/T4fw1WQ1WzMto/uQVW
 R+Lz1JBHN2o8NcPdG6z3L5SVdeogGFJc3Y7GHXOJ/LFKKexjFwiyreGJMeLGqP1VpycPL+h9O
 01JwwmCcBhbV86ukiZ6bfZVdFzi1oQg8pDYNQ82GT1h9l18OUjRm6J9tGm/hAIaO33YJupECB
 aGuzDxf4c+DbOYsV00jddobeACpgNgR49MAssUf4VEUiJYRMW5H6UxA3VbQOIp4x+yUBEu/EU
 d24ho3jtWO/mtLfD/U+TLlLFeuovEkE2tH6V31T6wLQlRJaNBasvb63HFfczHcT0+Mk7tiRoG
 Rt0uVJQNPtv1/ctdF2FsNFivbL9zz2R0HnqiglIm5hUO+Anc1W1ESkFpg==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/24 15:18, Christoph Hellwig wrote:
> Use the common helpers to find the btrfs logical address and to read fro=
m
> a specific mirror.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/140 | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/tests/btrfs/140 b/tests/btrfs/140
> index c680fe0a..fdff6eb2 100755
> --- a/tests/btrfs/140
> +++ b/tests/btrfs/140
> @@ -24,7 +24,6 @@ _supported_fs btrfs
>   _require_scratch_dev_pool 2
>
>   _require_btrfs_command inspect-internal dump-tree
> -_require_command "$FILEFRAG_PROG" filefrag
>   _require_odirect
>   # Overwriting data is forbidden on a zoned block device
>   _require_non_zoned_device "${SCRATCH_DEV}"
> @@ -71,7 +70,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 128K 0 128K" =
"$SCRATCH_MNT/foobar" |\
>   echo "step 2......corrupt file extent" >>$seqres.full
>
>   ${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
> -logical_in_btrfs=3D`${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar | _filter_f=
ilefrag | cut -d '#' -f 1`
> +logical_in_btrfs=3D$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   physical=3D$(get_physical ${logical_in_btrfs} 1)
>   devid=3D$(get_devid ${logical_in_btrfs} 1)
>   devpath=3D$(get_device_path ${devid})
> @@ -87,15 +86,7 @@ _scratch_mount
>   # step 3, 128k dio read (this read can repair bad copy)
>   echo "step 3......repair the bad copy" >>$seqres.full
>
> -# since raid1 consists of two copies, and the bad copy was put on strip=
e #1
> -# while the good copy lies on stripe #0, the bad copy only gets access =
when the
> -# reader's pid % 2 =3D=3D 1 is true
> -while true; do
> -	$XFS_IO_PROG -d -c "pread -b 128K 0 128K" "$SCRATCH_MNT/foobar" > /dev=
/null &
> -	pid=3D$!
> -	wait
> -	[ $((pid % 2)) =3D=3D 1 ] && break
> -done
> +_btrfs_direct_read_on_mirror 1 2 "$SCRATCH_MNT/foobar" 0 128K
>
>   _scratch_unmount
>
