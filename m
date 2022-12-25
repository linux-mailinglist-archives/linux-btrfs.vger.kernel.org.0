Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F273D655D3F
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Dec 2022 13:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiLYMvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 07:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYMvo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 07:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF033F
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 04:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671972656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oVcT5GImFQe7hTW9o2HDuSwFdLEVDkeZE/qzROIPkaE=;
        b=FUPPYMHIkJhpOz3AeHqtVf8guNgHvI0fzeQAaATddVofwkg/3LKVoKsUdSTUeHuowW5Hy6
        9aiOxwGupZrNnaQXUXfDd5nLSDtURYA2oN+MYYgZbB46Tq3ZGuB+cxVJpOsbXu1G8k1eB2
        SC89AiaVwK0Vc1zKrwHdeY4yert8NXk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-674-1QTIIhMiO9G6kQUYB0C4jw-1; Sun, 25 Dec 2022 07:50:54 -0500
X-MC-Unique: 1QTIIhMiO9G6kQUYB0C4jw-1
Received: by mail-pl1-f197.google.com with SMTP id j18-20020a170902da9200b00189b3b16addso6649060plx.23
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 04:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVcT5GImFQe7hTW9o2HDuSwFdLEVDkeZE/qzROIPkaE=;
        b=U8Jzk3+LSKzwzq8FrIF1g/Rd8vucWWKqpb98eHSi/cqfIg+zrQxfJEZwwRb4PF/lH/
         B7U+oqsNngzk53hIFfRO4Io9sa0iLgCIJqgB+TQkEAaovLSKWVJvVlsodxf0x5i1zYUm
         936UQ4BCVEvvXAR8ruIMBCN+k38pd5LTbPPPRVsTYc2ttwVmUcsN2yP7xYYhYg8iZSul
         AjpVWX8E1e0KcUBhxQ8V4kp/jVCHQQGRyzFhHVCnXl8JIqYJg3QLkJQKXd5IIDGhBoes
         IMy3HPqR0oY1dssfhA1ktzS0qs4cmaZge9IQ99Umj6QkvnyqN1NsSJ7Gte81KwNTBeKl
         I8Ow==
X-Gm-Message-State: AFqh2kpAkxL9evo7cndhfJZUbgFcWrP7S8wqY7sb0/Ala0LQu7aDj0qY
        nxkb9oFgsgcPQ25Y+c2dE9tdUCxe/cyeGgGIgATqi1LW1M6g2jkjz+LOfVUR1d/3E1TXJvwmIit
        w/Qm9iGQfqkmp14DTIvuiy3g=
X-Received: by 2002:a05:6a20:6a91:b0:ad:5a4d:95b5 with SMTP id bi17-20020a056a206a9100b000ad5a4d95b5mr33677072pzb.40.1671972653676;
        Sun, 25 Dec 2022 04:50:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuRlxkUk15LxQMopri1ERtwZcuURBQmjEy5zOdrQDaBANXtN7ITnVbDoUbuqybzz8/RnxAttQ==
X-Received: by 2002:a05:6a20:6a91:b0:ad:5a4d:95b5 with SMTP id bi17-20020a056a206a9100b000ad5a4d95b5mr33677061pzb.40.1671972653351;
        Sun, 25 Dec 2022 04:50:53 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o133-20020a62cd8b000000b00561d79f1064sm5282251pfg.57.2022.12.25.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 04:50:52 -0800 (PST)
Date:   Sun, 25 Dec 2022 20:50:49 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/154: migrate to python3
Message-ID: <20221225125049.nczymsopzbzrwfbm@zlang-mailbox>
References: <20221223025642.33496-1-wqu@suse.com>
 <20221225115146.t2y4adfguq2qtg74@zlang-mailbox>
 <8f58bb60-edb7-5bb8-ac6e-01df06593d95@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f58bb60-edb7-5bb8-ac6e-01df06593d95@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 25, 2022 at 08:11:02PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/12/25 19:51, Zorro Lang wrote:
> > On Fri, Dec 23, 2022 at 10:56:42AM +0800, Qu Wenruo wrote:
> > > Test case btrfs/154 is still using python2 script, which is already EOL.
> > > Some rolling distros like Archlinux is no longer providing python2
> > > package anymore.
> > > 
> > > This means btrfs/154 will be harder and harder to run.
> > > 
> > > To fix the problem, migreate the python script to python3, this involves
> > > the following changes:
> > > 
> > > - Change common/config to use python3
> > > - Strong type conversion between string and bytes
> > >    This means, anything involved in the forged bytes has to be bytes.
> > > 
> > >    And there is no safe way to convert forged bytes into string, unlike
> > >    python2.
> > >    I guess that's why the author went python2 in the first place.
> > > 
> > >    Thankfully os.rename() still accepts forged bytes.
> > > 
> > > - Use bytes specific checks for invalid chars.
> > > 
> > > The updated script can still cause the needed conflicts, can be verified
> > > through "btrfs ins dump-tree" command.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   common/config                   |  2 +-
> > >   src/btrfs_crc32c_forged_name.py | 22 ++++++++++++++++------
> > >   tests/btrfs/154                 |  4 ++--
> > >   3 files changed, 19 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/common/config b/common/config
> > > index b2802e5e..e2aba5a9 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -212,7 +212,7 @@ export NFS4_SETFACL_PROG="$(type -P nfs4_setfacl)"
> > >   export NFS4_GETFACL_PROG="$(type -P nfs4_getfacl)"
> > >   export UBIUPDATEVOL_PROG="$(type -P ubiupdatevol)"
> > >   export THIN_CHECK_PROG="$(type -P thin_check)"
> > > -export PYTHON2_PROG="$(type -P python2)"
> > > +export PYTHON3_PROG="$(type -P python3)"
> > 
> > How about:
> > 
> > export PYTHON_PROG="$(type -P python)"
> > export PYTHON2_PROG="$(type -P python2)"
> > export PYTHON3_PROG="$(type -P python3)"
> > 
> > maybe someone still need python2, or maybe someone doesn't care the version.
> 
> Even for distros which completely get rid of python2 and make python3
> default, there is still python3.
> And python is just a softlink to python3, which further links to the real
> python
> 
>  $ type -P python2
>  $ type -P python3
>  /usr/bin/python3
>  $ type -P python
>  /usr/bin/python
> 
>  $ ls -alh /usr/bin/python
>  lrwxrwxrwx 1 root root 7 Nov  1 22:18 /usr/bin/python -> python3
>  $ ls -alh /usr/bin/python3
>  lrwxrwxrwx 1 root root 10 Nov  1 22:18 /usr/bin/python3 -> python3.10
> 
> Secondly, for this particular case, we must distinguish python2 and python3,
> especially due to the strong requirement for string encoding.
> 
> 
> So to your PYTHON_PROG usage, no, it's not good at all, it's going to be
> distro dependent and will be a disaster if some one is using PYTHON_PROG.
> 
> For PYTHON2_PROG, there is no usage of it any more, thus I see now reason to
> define it.

OK, due to only btrfs/154 uses this PYTHON?_PROG thing now, we can talk about
that later. This patch looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Zorro
> > 
> > >   export SQLITE3_PROG="$(type -P sqlite3)"
> > >   export TIMEOUT_PROG="$(type -P timeout)"
> > >   export SETCAP_PROG="$(type -P setcap)"
> > > diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
> > > index 6c08fcb7..d29bbb70 100755
> > > --- a/src/btrfs_crc32c_forged_name.py
> > > +++ b/src/btrfs_crc32c_forged_name.py
> > > @@ -59,9 +59,10 @@ class CRC32(object):
> > >       # deduce the 4 bytes we need to insert
> > >       for c in struct.pack('<L',fwd_crc)[::-1]:
> > >         bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
> > > -      bkd_crc ^= ord(c)
> > > +      bkd_crc ^= c
> > > -    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
> > > +    res = bytes(s[:pos], 'ascii') + struct.pack('<L', bkd_crc) + \
> > > +          bytes(s[pos:], 'ascii')
> > >       return res
> > >     def parse_args(self):
> > > @@ -72,6 +73,12 @@ class CRC32(object):
> > >                           help="number of forged names to create")
> > >       return parser.parse_args()
> > > +def has_invalid_chars(result: bytes):
> > > +    for i in result:
> > > +        if i == 0 or i == int.from_bytes(b'/', byteorder="little"):
> > > +            return True
> > > +    return False
> > > +
> > >   if __name__=='__main__':
> > >     crc = CRC32()
> > > @@ -80,12 +87,15 @@ if __name__=='__main__':
> > >     args = crc.parse_args()
> > >     dirpath=args.dir
> > >     while count < args.count :
> > > -    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
> > > +    origname = os.urandom (89).hex()[:-1].strip ("\x00")
> > >       forgename = crc.forge(wanted_crc, origname, 4)
> > > -    if ("/" not in forgename) and ("\x00" not in forgename):
> > > +    if not has_invalid_chars(forgename):
> > >         srcpath=dirpath + '/' + str(count)
> > > -      dstpath=dirpath + '/' + forgename
> > > -      file (srcpath, 'a').close()
> > > +      # We have to convert all strings to bytes to concatenate the forged
> > > +      # name (bytes).
> > > +      # Thankfully os.rename() can accept bytes directly.
> > > +      dstpath=bytes(dirpath, "ascii") + bytes('/', "ascii") + forgename
> > > +      open(srcpath, mode="a").close()
> > >         os.rename(srcpath, dstpath)
> > >         os.system('btrfs fi sync %s' % (dirpath))
> > >         count+=1;
> > > diff --git a/tests/btrfs/154 b/tests/btrfs/154
> > > index 240c504c..6be2d5f6 100755
> > > --- a/tests/btrfs/154
> > > +++ b/tests/btrfs/154
> > > @@ -21,7 +21,7 @@ _begin_fstest auto quick
> > >   _supported_fs btrfs
> > >   _require_scratch
> > > -_require_command $PYTHON2_PROG python2
> > > +_require_command $PYTHON3_PROG python3
> > >   # Currently in btrfs the node/leaf size can not be smaller than the page
> > >   # size (but it can be greater than the page size). So use the largest
> > > @@ -42,7 +42,7 @@ _scratch_mount
> > >   #    ...
> > >   #
> > > -$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
> > > +$PYTHON3_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
> > >   echo "Silence is golden"
> > >   # success, all done
> > > -- 
> > > 2.39.0
> > > 
> > 
> 

