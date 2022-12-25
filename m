Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CE655CF7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Dec 2022 12:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiLYLwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 06:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYLwm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 06:52:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A83F44
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671969116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yCxE+7UiMVvRtvAbvK6NVI5FLsNPw0Ca9220qsuttJ0=;
        b=cS5rcXGSXq5MeQ6H6q4x0uYlheEBKVHLQ9JKwRujnjUNE9QZZHGvrbOAwJwCa05tOJR6LP
        ag73+j6J9lTQhggPS6qE17Mo1nHaqVjPcrlg9njdKdQWhp0GTuwdggpu7dPaxiPM9vSNY+
        +jhzdyGbhKjFlsgWq1+Fm50zxuVff40=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-PZZFBUvgNWy1cc5com-sdQ-1; Sun, 25 Dec 2022 06:51:52 -0500
X-MC-Unique: PZZFBUvgNWy1cc5com-sdQ-1
Received: by mail-pj1-f72.google.com with SMTP id me18-20020a17090b17d200b00219f8dc7cb3so7735964pjb.4
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 03:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCxE+7UiMVvRtvAbvK6NVI5FLsNPw0Ca9220qsuttJ0=;
        b=Ila60E/+PAnoE8EW1h9hViskQgDVhnvSi8KxG42PVR/lUF/NyoZsguDfTkTJS+Fi9I
         /40o8FmBM/PlcMyq7k2En5SIZGPnAfDSB/Uidfflx8L9grHdhXhwUEqk+kzo48oqUswn
         0SScVHsQ7fqF17HMhDDNIK5kIjcuQdDwgdGvcIQ1Zmi6uQPEfugUzFU5VJHY1xqD/7sA
         dj6OJl/iahahHEprjXrCHi9SUbqRO74ih4/5KYAxZQ2ZXfXaL0/sNJ3OiOpIfdECyY9e
         LNjIgKWQmpfxHPMHMHRJjuQDYGQEmx2uZeJIpDkuH2L5GUA47BbA0vxwoAIeVgUHN2nY
         2CtA==
X-Gm-Message-State: AFqh2kr+0lcjvhbTHg4C4u7mYtXKk0cKbevENUFq3/6i7goazQk4iBIb
        UxEf890oFy0v9sTfvyF47a+60+4KEZb7MuZBxG/1gCXmLBZltgf5ZUuBE+3dKd+1Ul7y93TI+v/
        eESeheihEcyQ0N/7R4uQfnWw=
X-Received: by 2002:a17:902:d4ce:b0:191:770:328d with SMTP id o14-20020a170902d4ce00b001910770328dmr43672499plg.46.1671969111184;
        Sun, 25 Dec 2022 03:51:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNU/3kaxOzkhCV+PE8+yegjc0HgACQfXkAsOVEJ6hxHbCu54AHThH9+RvHudqh3lHGXSZlag==
X-Received: by 2002:a17:902:d4ce:b0:191:770:328d with SMTP id o14-20020a170902d4ce00b001910770328dmr43672481plg.46.1671969110882;
        Sun, 25 Dec 2022 03:51:50 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902a38e00b00176ab6a0d5fsm5298960pla.54.2022.12.25.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 03:51:50 -0800 (PST)
Date:   Sun, 25 Dec 2022 19:51:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/154: migrate to python3
Message-ID: <20221225115146.t2y4adfguq2qtg74@zlang-mailbox>
References: <20221223025642.33496-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223025642.33496-1-wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 23, 2022 at 10:56:42AM +0800, Qu Wenruo wrote:
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

How about:

export PYTHON_PROG="$(type -P python)"
export PYTHON2_PROG="$(type -P python2)"
export PYTHON3_PROG="$(type -P python3)"

maybe someone still need python2, or maybe someone doesn't care the version.

Thanks,
Zorro

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

