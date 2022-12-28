Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23E65764A
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Dec 2022 13:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiL1MEY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 28 Dec 2022 07:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiL1MEL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 07:04:11 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94376316;
        Wed, 28 Dec 2022 04:04:09 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id b2so15870958pld.7;
        Wed, 28 Dec 2022 04:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GURb7QwTI14TrIXmcpjD6p9u8NUJhyZyca3K1LeZs0=;
        b=FQSkrbxKf+T1wU19yp8rjvqrN+TUl/tqfYH+k/IZQtpuaKS1+qe3HLQ/nl+UGB0Z9c
         CZqI3aluB/mge8D0zX+PGyO6XOpnmox/TJTamsmkngc+ghGELkrMkRTij7s4bEOa79E5
         9xdltr/xkyECVpFKvwq8P3rA3zoyBaC+y4qm5fPPsionuYKVLnfDp1I83K/CjHpSYp+J
         SEW3qwfdibNuzCC+1mZyd2UlGbX27QO2RCEWm5DEIpvle612oQ1ZtE6wgmYEAWRq+OgU
         kXpOjWyYNV2uT3bqSBdEpEld9xtNd7rqOrr9/a23P5GKLQwh3XYkop+DsO8/wgwyFLmg
         OcmA==
X-Gm-Message-State: AFqh2kr5dmaWt917k+WMoTd1/o5pX6MKGN5puZHKrmzBlfET14114nv7
        XL1NYPYbD2bl3Ld+uixQRnnX76LSVno=
X-Google-Smtp-Source: AMrXdXswDGVtEFLH7qQYLTcwrNlD+QS0JuUY6BvhmRbTnclsisB6dmLqLlMyDqvGykuFzVFGG0v/Xw==
X-Received: by 2002:a17:90a:6f65:b0:219:11f3:cab6 with SMTP id d92-20020a17090a6f6500b0021911f3cab6mr27837778pjk.34.1672229048878;
        Wed, 28 Dec 2022 04:04:08 -0800 (PST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090abc8f00b002192db1f8e8sm9580504pjr.23.2022.12.28.04.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:04:08 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id jn22so15841889plb.13;
        Wed, 28 Dec 2022 04:04:08 -0800 (PST)
X-Received: by 2002:a17:90a:d081:b0:225:efc0:2e2f with SMTP id
 k1-20020a17090ad08100b00225efc02e2fmr1033859pju.151.1672229048180; Wed, 28
 Dec 2022 04:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20221223025642.33496-1-wqu@suse.com>
In-Reply-To: <20221223025642.33496-1-wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 28 Dec 2022 07:03:31 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-EhDPVr1oxmRY_ESs8LG7gighE6RrOdjrxg7qBysOYig@mail.gmail.com>
Message-ID: <CAEg-Je-EhDPVr1oxmRY_ESs8LG7gighE6RrOdjrxg7qBysOYig@mail.gmail.com>
Subject: Re: [PATCH] btrfs/154: migrate to python3
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 22, 2022 at 10:03 PM Qu Wenruo <wqu@suse.com> wrote:
>
> Test case btrfs/154 is still using python2 script, which is already EOL.
> Some rolling distros like Archlinux is no longer providing python2
> package anymore.
>
> This means btrfs/154 will be harder and harder to run.
>
> To fix the problem, migreate the python script to python3, this involves
> the following changes:
>
> - Change common/config to use python3
> - Strong type conversion between string and bytes
>   This means, anything involved in the forged bytes has to be bytes.
>
>   And there is no safe way to convert forged bytes into string, unlike
>   python2.
>   I guess that's why the author went python2 in the first place.
>
>   Thankfully os.rename() still accepts forged bytes.
>
> - Use bytes specific checks for invalid chars.
>
> The updated script can still cause the needed conflicts, can be verified
> through "btrfs ins dump-tree" command.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/config                   |  2 +-
>  src/btrfs_crc32c_forged_name.py | 22 ++++++++++++++++------
>  tests/btrfs/154                 |  4 ++--
>  3 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/common/config b/common/config
> index b2802e5e..e2aba5a9 100644
> --- a/common/config
> +++ b/common/config
> @@ -212,7 +212,7 @@ export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
>  export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
>  export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
>  export THIN_CHECK_PROG="$(type -P thin_check)"
> -export PYTHON2_PROG="$(type -P python2)"
> +export PYTHON3_PROG="$(type -P python3)"
>  export SQLITE3_PROG="$(type -P sqlite3)"
>  export TIMEOUT_PROG="$(type -P timeout)"
>  export SETCAP_PROG="$(type -P setcap)"
> diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
> index 6c08fcb7..d29bbb70 100755
> --- a/src/btrfs_crc32c_forged_name.py
> +++ b/src/btrfs_crc32c_forged_name.py
> @@ -59,9 +59,10 @@ class CRC32(object):
>      # deduce the 4 bytes we need to insert
>      for c in struct.pack('<L',fwd_crc)[::-1]:
>        bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
> -      bkd_crc ^= ord(c)
> +      bkd_crc ^= c
>
> -    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
> +    res = bytes(s[:pos], 'ascii') + struct.pack('<L', bkd_crc) + \
> +          bytes(s[pos:], 'ascii')
>      return res
>
>    def parse_args(self):
> @@ -72,6 +73,12 @@ class CRC32(object):
>                          help="number of forged names to create")
>      return parser.parse_args()
>
> +def has_invalid_chars(result: bytes):
> +    for i in result:
> +        if i == 0 or i == int.from_bytes(b'/', byteorder="little"):
> +            return True
> +    return False
> +
>  if __name__=='__main__':
>
>    crc = CRC32()
> @@ -80,12 +87,15 @@ if __name__=='__main__':
>    args = crc.parse_args()
>    dirpath=args.dir
>    while count < args.count :
> -    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
> +    origname = os.urandom (89).hex()[:-1].strip ("\x00")
>      forgename = crc.forge(wanted_crc, origname, 4)
> -    if ("/" not in forgename) and ("\x00" not in forgename):
> +    if not has_invalid_chars(forgename):
>        srcpath=dirpath + '/' + str(count)
> -      dstpath=dirpath + '/' + forgename
> -      file (srcpath, 'a').close()
> +      # We have to convert all strings to bytes to concatenate the forged
> +      # name (bytes).
> +      # Thankfully os.rename() can accept bytes directly.
> +      dstpath=bytes(dirpath, "ascii") + bytes('/', "ascii") + forgename
> +      open(srcpath, mode="a").close()
>        os.rename(srcpath, dstpath)
>        os.system('btrfs fi sync %s' % (dirpath))
>        count+=1;
> diff --git a/tests/btrfs/154 b/tests/btrfs/154
> index 240c504c..6be2d5f6 100755
> --- a/tests/btrfs/154
> +++ b/tests/btrfs/154
> @@ -21,7 +21,7 @@ _begin_fstest auto quick
>
>  _supported_fs btrfs
>  _require_scratch
> -_require_command $PYTHON2_PROG python2
> +_require_command $PYTHON3_PROG python3
>
>  # Currently in btrfs the node/leaf size can not be smaller than the page
>  # size (but it can be greater than the page size). So use the largest
> @@ -42,7 +42,7 @@ _scratch_mount
>  #    ...
>  #
>
> -$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
> +$PYTHON3_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
>  echo "Silence is golden"
>
>  # success, all done
> --
> 2.39.0
>

This test makes my eyes bleed, but that's not a reason to say no to
this patch...

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
