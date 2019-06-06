Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C493729A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfFFLQ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:16:29 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35795 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfFFLQ3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jun 2019 07:16:29 -0400
Received: by mail-vk1-f193.google.com with SMTP id k1so366726vkb.2;
        Thu, 06 Jun 2019 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UKUoeS7QojS6XWNuB0gM09E8mCaD4h6+Tfr0cVr2N2E=;
        b=pHGiNDmTLKC5O6z8p74TmMUPLn19CLTtXY7BqZg12uwJdAup3aMn7aWbQtNfTexZsd
         6pUy7aOCGfRY8xfdy9vuhSMVZPHHXsv96yXmJpiO8LoB0puGO5+79Jgad9m0JDMso+wE
         lotFOUiw0750fCzrcOGlzzgC1hhk4QM7oHW3Ga+uUIdwW60a/gmDAxrNBqy9uBJ+0sGw
         ejmyIu7ZoMyFlwX1QDDIdySSUt7QNzudE9V60GK/5CCRa0GktxiBKifag61IbHqBIduy
         Qw+uM1AqZzDN48Ht1CJy9nvQgDgBun9UzmF3xLzvU/HpIX54H4EU4HhycfEMWdZ4GYKb
         iCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UKUoeS7QojS6XWNuB0gM09E8mCaD4h6+Tfr0cVr2N2E=;
        b=KzmU5uvy9p21lUjyX73oAQb6aMqN8UdZ+q3YJTLT95z2f0W6C4sNaObHd8eWAA0/ZG
         zSo2A+araDnT0as32JIbqbYE1GYZIJCP9wkbHOwlrMyHaVgEKKpgUk8YfAB1X/uW2s9s
         Z5sKr+ukrlsW5kibZlzbEGkXEdW3BjPXZ/G/wcVUEaT5mU7F3CnuNx7oOEDliOy5WhOL
         HK4aYoys6r+e9epbOMD+btSUwX81Wz4PDBKUXmxNoXlD8muLP11PXBja7vm9lrIBtGyP
         YyxdPqLS2nnMlJgnzalfZ0yrlg+WcEyr+6nweCXRSdHqv1qO2LNeGytwZVNrukCvYPaa
         l7nQ==
X-Gm-Message-State: APjAAAWHuGwtBBdy5VzRtWK1X3rAsLQ9TBK/HtT9sQsajzuPxtS29WYq
        gtHxeUHMBc/+v1M+xZqq2g+eQDS+PhaSuUNMVho=
X-Google-Smtp-Source: APXvYqwAoLiuf4yzksxzekyFYHZGy7i/WDfSN1bo1TPVCPBh6RoyTFE6m7SARXpLWRzKGCFgPmn5PWV8b3xIF6CLXdw=
X-Received: by 2002:a1f:12d5:: with SMTP id 204mr5925695vks.4.1559819788057;
 Thu, 06 Jun 2019 04:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190606100754.14575-1-jthumshirn@suse.de>
In-Reply-To: <20190606100754.14575-1-jthumshirn@suse.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 6 Jun 2019 12:16:17 +0100
Message-ID: <CAL3q7H665Rh7P8bwxNxHJVFibvb6pSg7MeFaqhsRWKx4jMW8JA@mail.gmail.com>
Subject: Re: [PATCH fstests] btrfs: add validation of compression options to btrfs/048
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 6, 2019 at 11:10 AM Johannes Thumshirn <jthumshirn@suse.de> wro=
te:
>
> The current btrfs/048 test-case did not check the behavior of properties
> with options like compression and with the compression level supplied.
>
> Add test cases for compression with compression level as well so we can b=
e
> sure we don't regress there.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  tests/btrfs/048     | 15 +++++++++++++++
>  tests/btrfs/048.out | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/tests/btrfs/048 b/tests/btrfs/048
> index 8bb10a904bc9..af2d4ff34414 100755
> --- a/tests/btrfs/048
> +++ b/tests/btrfs/048
> @@ -226,5 +226,20 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT compressi=
on 'lz' 2>&1 | _filter_scrat
>  $BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
>  $BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^gener=
ation'
>
> +echo -e "\nTesting argument validation with options"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo:9' 2>&1 | _f=
ilter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zlib:3' 2>&1 | _=
filter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zstd:0' 2>&1 | _=
filter_scratch
> +echo "***"

For those 3 cases, there's no need to "2>&1 | _filter_scratch", since
we don't expect any output from the commands in the golden output.

Other than that, looks good to me, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> +
> +echo -e "\nTesting invalid argument validation with options, should fail=
"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz:9' 2>&1 | _fi=
lter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli:0' 2>&1 | _f=
ilter_scratch
> +echo "***"
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst:3' 2>&1 | _f=
ilter_scratch
> +
>  status=3D0
>  exit
> diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
> index 16a785a642f7..016eba265b01 100644
> --- a/tests/btrfs/048.out
> +++ b/tests/btrfs/048.out
> @@ -92,3 +92,15 @@ Testing generation is unchanged after failed validatio=
n
>  generation             7
>  ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
>  generation             7
> +
> +Testing argument validation with options
> +***
> +***
> +***
> +
> +Testing invalid argument validation with options, should fail
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> +***
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> +***
> +ERROR: failed to set compression for SCRATCH_MNT: Invalid argument
> --
> 2.16.4
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
