Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9662E8FAB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 04:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbhADDxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 22:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbhADDxk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Jan 2021 22:53:40 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4EC061574
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Jan 2021 19:53:00 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id h10so14668012pfo.9
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Jan 2021 19:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIJ5mXM20MFWWFluRgqky2fw+x0VWEq8L85QyEVo3CA=;
        b=BJuXR82Z5dxLmhf9R5yLhZrfaf5bajTjgOTXvTFADgruzo5qjPTAwLWlhrAPppnjO5
         t9pVcVK/aAg/AP5HxwgXPax1B6a9B77jHJbmf1uuY9GsqWjnvyPcLa/x7Pvl07Ye2J4o
         i9DOUKOgAQjSq76Kamic0qJFCbyZYts4+jSbZWcG/LTTOkA0tz4WIL5wReb/+eeadxcx
         BbwZ8MYbvjItZcBJVZm4FzSbff3GW38uhs3VKpOfPBN91CITK2DpVtNjc+xNrzZNKl4E
         3HkjqCK7g70YhqZagoGnkqELEKgY9hSIxaj1NojSHjb2URYMoidl2QIIhWdefNKu2tyK
         Rs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIJ5mXM20MFWWFluRgqky2fw+x0VWEq8L85QyEVo3CA=;
        b=jrqjHSUlbjPPKVXdVgm+FSgvSYZhNsjwnS5nl9F8H6+WSO92b69uwwHoPFXBSxoYSD
         4AY9TnzjgjOwXmUs9MYn9ZtmbFLkl09SEWPGHsnxrEs+n5iEwPRGSB2+zzSPKfvS0ZA9
         KkjGzMP7U7vuxOLSrkT9oOwUluEwPx67bw5uA1MpQR3Rdisf2rqT2L+y9IfdCgX3mCyH
         nk1aC5a+a4TnVlhAZ2C4h/rDohBxbdDggpM0UkvOvteUXMC9SW0p4MMJ++5zs9bjzmre
         CrVrUoKhtpzZqTwBusRZAOgR/Kipi17leH5ofzlapF3oiYorZogJdk+tyUk3/ml6O/mz
         HYhg==
X-Gm-Message-State: AOAM531h73W7J/rVuhgR6K26jn8jYoGKlXXfNLI6H17ocoD0Eb5ezCRo
        0lWFOtOAMko0qL8/3NGCk9m/dRz4lQg=
X-Google-Smtp-Source: ABdhPJyOIj09ZYnGPQ8/wlwj9u3dW6XCx/ue0NmLfz1Y4TZj8Dq53tKybCZ3HiD/pRujn3HbpX/69w==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr22880093pgg.14.1609732379317;
        Sun, 03 Jan 2021 19:52:59 -0800 (PST)
Received: from hosting.home (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id p9sm19960773pjb.3.2021.01.03.19.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:52:58 -0800 (PST)
Sender: Sheng Mao <ks8xntk9mds5i@gmail.com>
Date:   Sun, 3 Jan 2021 20:52:56 -0700
From:   Sheng Mao <shngmao@gmail.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs-progs: add Kernel TLS to btrfs send/receive
Message-ID: <20210104035256.GB4043@hosting.home>
References: <20210102154713.GA2785@hosting.home>
 <20210103124513.FBC5.409509F4@e16-tech.com>
 <20210103191926.E4C7.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20210103191926.E4C7.409509F4@e16-tech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yugui,

Thanks for the testing! The error message from your two failed cases
shows that sender is still working on splice. So I made two patches:

- directly write to socket, instead of writing to pipe: on my
computer, it is much slower to do so
- enlarge pipe buffer size

I am not sure whether these two can help debugging or not.

BTW, you run centos 8.3 on both server and client, I guess they are
backported from latest 5.x kernel. May I know what version is it? 

Regards,
Sheng


On Sun, Jan 03, 2021 at 07:19:28PM +0800, Wang Yugui wrote:
> Hi, Sheng
> 
> Now we can reproduce this CRC error.
> 
> client is running
> 	/usr/bin/time btrfs-5.9 send --conn-addr 10.0.0.76 --tcp-port 8080 /archive/movie2
> 
> server is running
> 	/usr/bin/time btrfs-5.9 receive --listen-addr :: --tcp-port 8080 --dump
> 
> On client,  the command pstack 13623(pid of btrfs-5.9 send') is slow,
> and then 'ERROR: crc32 mismatch in command' happen in server side.
> 
> A little difficult to understand.
> 
> It seems thread-sync problem in client side?
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/01/03
> 
> > Hi, Sheng
> > 
> > I test it again with this patch, and huge performance improvement as
> > reported!
> > 
> > > I have made a patch to fix it:
> > > https://patchwork.kernel.org/project/linux-btrfs/patch/20201226214606.49241-1-shngmao@gmail.com/
> > > 
> > > The benchmark result is recorded in github issue #324:
> > > https://github.com/kdave/btrfs-progs/issues/324#issuecomment-751813175
> > 
> > but sometimes there is 'ERROR: crc32 mismatch in command'.
> > 
> > This is a 190G subvolume to send/receive, and then sometime slient error
> > in transfer?
> > 
> > failed case 1:
> > [root@T620 btrfs-progs]# ./test.send.listen-addr.sh 
> > + server=10.0.0.76
> > + sleep 2
> > + ssh 10.0.0.76 /usr/bin/time btrfs-5.9 receive --listen-addr :: --tcp-port 8080 --dump
> > + /usr/bin/time btrfs-5.9 send --conn-addr 10.0.0.76 --tcp-port 8080 /archive/movie2
> > ERROR: crc32 mismatch in command
> > ERROR: failed to dump the send stream: Invalid argument
> > Command exited with non-zero status 1
> > 28.39user 49.96system 2:02.01elapsed 64%CPU (0avgtext+0avgdata 5920maxresident)k
> > 96inputs+0outputs (1major+390minor)pagefaults 0swaps
> > + sleep 1
> > + cat time.send
> > At subvol /archive/movie2
> > ERROR: failed to read stream from kernel: Connection reset by peer
> > Command exited with non-zero status 104
> > 0.30user 130.54system 2:00.35elapsed 108%CPU (0avgtext+0avgdata 5564maxresident)k
> > 192302416inputs+16outputs (1major+457minor)pagefaults 0swaps
> > 
> > failed case 2:
> > [root@T620 btrfs-progs]# ./test.send.listen-addr.sh 
> > + server=10.0.0.76
> > + sleep 2
> > + ssh 10.0.0.76 /usr/bin/time btrfs-5.9 receive --listen-addr :: --tcp-port 8080 --dump
> > + /usr/bin/time btrfs-5.9 send --conn-addr 10.0.0.76 --tcp-port 8080 /archive/movie2
> > ERROR: crc32 mismatch in command
> > ERROR: failed to dump the send stream: Invalid argument
> > Command exited with non-zero status 1
> > 28.40user 48.62system 1:39.13elapsed 77%CPU (0avgtext+0avgdata 5920maxresident)k
> > 0inputs+0outputs (0major+320minor)pagefaults 0swaps
> > + sleep 1
> > + cat time.send
> > At subvol /archive/movie2
> > ERROR: failed to read stream from kernel: Connection reset by peer
> > 
> > 
> > 
> > 
> > OK case 1:
> > 
> > + server=10.0.0.76
> > + ssh 10.0.0.76 btrfs subvolume delete -c /btrfs/movie2
> > Delete subvolume (commit): '/btrfs/movie2'
> > + sleep 2
> > + ssh 10.0.0.76 /usr/bin/time btrfs-5.9 receive --listen-addr :: --tcp-port 8080 /btrfs
> > + /usr/bin/time btrfs-5.9 send --conn-addr 10.0.0.76 --tcp-port 8080 /archive/movie2
> > At subvol movie2
> > + sleep 1
> > 47.65user 267.49system 5:20.98elapsed 98%CPU (0avgtext+0avgdata 5828maxresident)k
> > 96inputs+396806624outputs (1major+509minor)pagefaults 0swaps
> > + cat time.send
> > At subvol /archive/movie2
> > 0.52user 249.44system 5:19.27elapsed 78%CPU (0avgtext+0avgdata 5740maxresident)k
> > 174679448inputs+8outputs (1major+457minor)pagefaults 0swaps
> > 
> > 
> > OK case 1:
> > 
> > + server=10.0.0.76
> > + sleep 2
> > + ssh 10.0.0.76 /usr/bin/time btrfs-5.9 receive --listen-addr :: --tcp-port 8080 --dump
> > + /usr/bin/time btrfs-5.9 send --conn-addr 10.0.0.76 --tcp-port 8080 /archive/movie2
> > 61.53user 104.62system 3:21.60elapsed 82%CPU (0avgtext+0avgdata 5684maxresident)k
> > 0inputs+0outputs (0major+313minor)pagefaults 0swaps
> > + sleep 1
> > + cat time.send
> > At subvol /archive/movie2
> > 0.60user 231.95system 3:19.91elapsed 116%CPU (0avgtext+0avgdata 5768maxresident)k
> > 66606224inputs+8outputs (0major+394minor)pagefaults 0swaps
> > 
> > 
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/01/03
> > 
> > > Hi Yugui,
> > > 
> > > Thank you for the benchmark!
> > > 
> > > I forgot to mention the CRC. There is a faster version of CRC but
> > > current receive buffer `btrfs_send_stream::read_buf` is not aligned
> > > to unsigned long.
> > > 
> > > I have made a patch to fix it:
> > > https://patchwork.kernel.org/project/linux-btrfs/patch/20201226214606.49241-1-shngmao@gmail.com/
> > > 
> > > The benchmark result is recorded in github issue #324:
> > > https://github.com/kdave/btrfs-progs/issues/324#issuecomment-751813175
> > > 
> > > In addition, on the server side, would you mind to try:
> > > 
> > > btrfs-5.9 receive --listen-addr :: --tcp-port 8080 --dump &> /dev/null
> > > 
> > > --dump only writes to stdout thus we can see network-only performance.
> > > 
> > > Thank you!
> > > 
> > > On Sat, Jan 02, 2021 at 06:45:32PM +0800, Wang Yugui wrote:
> > > > To: Sheng
> > > > 
> > > > some test result on 10Gbps.
> > > > 
> > > > Server:dell Precision T7610 Xeon(R) CPU E5-2660 v2
> > > > Client: dell PowerEdge T620 Xeon(R) CPU E5-2680 v2
> > > > OS: centos 8.3(gnutls-3.6.14-6.el8.x86_64)
> > > > 
> > > > test script:
> > > > server=10.0.0.76
> > > > ssh ${server} btrfs-5.9 subvolume delete /btrfs/movie2
> > > > ssh ${server} /usr/bin/time btrfs-5.9 receive --listen-addr :: --tcp-port 8080 /btrfs &
> > > > sleep 2
> > > > /usr/bin/time btrfs-5.9 send --conn-addr ${server} --tcp-port 8080 /archive/movie2 2>time.send
> > > > sleep 1
> > > > cat time.send
> > > > 
> > > > test result:
> > > > It works with about 200 MB/s. slow than expacted.
> > > > top result:
> > > >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> > > >    7479 root      20   0   45568   5200   4540 R 100.0   0.0   8:16.05 btrfs-5.9 receive --listen-addr
> > > > 
> > > > #pstack 7479
> > > > #0  __crc32c_le (crc=2848417421, data=0x7ffe68ee038b "\277g\276+\022\nZ", length=<optimized out>) at crypto/crc32c.c:213
> > > > #1  0x00000000004637ed in crc32c_le (crc=crc@entry=0, data=data@entry=0x7ffe68edb004 "O\300", length=length@entry=49241) at crypto/crc32c.c:223
> > > > #2  0x000000000045b71a in read_cmd (sctx=0x7ffe68edb000) at common/send-stream.c:141
> > > > #3  read_and_process_cmd (sctx=0x7ffe68edb000) at common/send-stream.c:330
> > > > 
> > > > That is to say, for high speed network/disk config,  the current bottleneck
> > > > of btrfs send/receive is the CRC process in btrfs receive side.
> > > > 
> > > > Best Regards
> > > > Wang Yugui (wangyugui@e16-tech.com)
> > > > 2021/01/02
> > > > 
> > > > > From: Sheng Mao <shngmao@gmail.com>
> > > > > 
> > > > > Currently, btrfs send outputs to a pipe or a file;
> > > > > btrfs receive inputs from a pipe or a file.
> > > > > The pipe can be a SSH or a stunnel connection.
> > > > > btrfs send/receive itself doesn't handle any connection.
> > > > > 
> > > > > Kernel introduces TLS in version 4.13 (referred as ktls).
> > > > > Ktls provides a transparent TLS 1.2/1.3 connection:
> > > > > from user space aspect, applications use a normal socket
> > > > > fd to read/write from/to. This model fits into btrfs send's
> > > > > design well: btrfs first writes to a pipe and then splices
> > > > > data from pipe to the final fd (which is a file or pipe).
> > > > > Ktls simply replaces the final fd with the ktls socket fd.
> > > > > According to ktls' author, ktls can boost performance for
> > > > > 2~7%. Ktls helps less on receiving side: btrfs receive
> > > > > processes data in user space. But btrfs receive still can
> > > > > use transparent TLS layer.
> > > > > 
> > > > > I have implemented ktls for btrfs send/receive. Here are
> > > > > the key features:
> > > > > 
> > > > > - Use GnuTLS for handshake. OpenSSL is not suitable for this
> > > > > task, we need to pass IV and key from handshake session to
> > > > > kernel setting.
> > > > > - Use PSK (pre-shared key) for handshake. User can use --key
> > > > > to use a key file or input password on prompt.
> > > > > - Key file is checked as PEM format first; if it fails, key
> > > > > file is treated as raw binary file.
> > > > > - Three TLS modes are supported: none (raw TCP), TLS 1.2 + GCM
> > > > > 128/256, TLS 1.3 + GCM 128.
> > > > > - DTLS, certificate, Secure Remote Password (SRP) are not
> > > > > supported yet.
> > > > > 
> > > > > Issue: #326
> > > > > Signed-off-by: Sheng Mao <shngmao@gmail.com>
> > > > > ---
> > > > >  common/ktls.c | 702 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  common/ktls.h |  57 ++++
> > > > >  2 files changed, 759 insertions(+)
> > > > >  create mode 100644 common/ktls.c
> > > > >  create mode 100644 common/ktls.h
> > > > > 
> > > > > diff --git a/common/ktls.c b/common/ktls.c
> > > > > new file mode 100644
> > > > > index 00000000..a4d670e3
> > > > > --- /dev/null
> > > > > +++ b/common/ktls.c
> > > > > @@ -0,0 +1,702 @@
> > > > > +/*
> > > > > + * Copyright (C) 2020 Sheng Mao.  All rights reserved.
> > > > > + *
> > > > > + * This program is free software; you can redistribute it and/or
> > > > > + * modify it under the terms of the GNU General Public
> > > > > + * License v2 as published by the Free Software Foundation.
> > > > > + *
> > > > > + * This program is distributed in the hope that it will be useful,
> > > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > > > + * General Public License for more details.
> > > > > + */
> > > > > +
> > > > > +#include <stdio.h>
> > > > > +#include <stdlib.h>
> > > > > +#include <string.h>
> > > > > +
> > > > > +#include <arpa/inet.h>
> > > > > +#include <fcntl.h>
> > > > > +#include <netdb.h>
> > > > > +#include <netinet/in.h>
> > > > > +#include <netinet/ip.h>
> > > > > +#include <netinet/tcp.h>
> > > > > +#include <sys/mman.h>
> > > > > +#include <sys/socket.h>
> > > > > +#include <sys/stat.h>
> > > > > +#include <sys/types.h>
> > > > > +#include <unistd.h>
> > > > > +#include <termios.h>
> > > > > +#include <sys/stat.h>
> > > > > +
> > > > > +#include <linux/tls.h>
> > > > > +
> > > > > +#include <gnutls/gnutls.h>
> > > > > +
> > > > > +#include <common/utils.h>
> > > > > +
> > > > > +#include "ktls.h"
> > > > > +
> > > > > +enum { KTLS_MAX_PASSWORD_LENGTH = 256, KTLS_MAX_PRIORITY_STRING_LENTH = 256 };
> > > > > +
> > > > > +enum {
> > > > > +	KTLS_STAGE_NOT_HANDSHAKED,
> > > > > +	KTLS_STAGE_HAS_HANDSHAKED,
> > > > > +};
> > > > > +
> > > > > +enum ktls_tls_mode_t {
> > > > > +	KTLS_TLS_MODE_NONE = 0,
> > > > > +	KTLS_TLS_12_128_GCM,
> > > > > +	KTLS_TLS_13_128_GCM,
> > > > > +	KTLS_TLS_12_256_GCM
> > > > > +};
> > > > > +
> > > > > +struct ktls_session {
> > > > > +	gnutls_session_t session;
> > > > > +	gnutls_certificate_credentials_t crt_cred;
> > > > > +
> > > > > +	gnutls_psk_server_credentials_t psk_cred_server;
> > > > > +	gnutls_psk_client_credentials_t psk_cred_client;
> > > > > +
> > > > > +	uint8_t role;
> > > > > +	uint8_t stage;
> > > > > +	enum ktls_tls_mode_t tls_mode;
> > > > > +};
> > > > > +
> > > > > +static gnutls_datum_t ktls_psk_username = { 0 };
> > > > > +static gnutls_datum_t ktls_psk_key = { 0 };
> > > > > +
> > > > > +static void ktls_print_logs(int level, const char *msg)
> > > > > +{
> > > > > +	if (bconf.verbose >= level)
> > > > > +		printf("GnuTLS [%d]: %s", level, msg);
> > > > > +}
> > > > > +
> > > > > +int ktls_set_psk_session_from_password_prompt(struct ktls_session *session,
> > > > > +					      const char *username)
> > > > > +{
> > > > > +	struct termios orig_term_flags, passwd_term_flags;
> > > > > +	char passwd[KTLS_MAX_PASSWORD_LENGTH];
> > > > > +	int passwd_sz = 0;
> > > > > +	int stdin_fd = 0;
> > > > > +
> > > > > +	if (!session)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	if (session->tls_mode == KTLS_TLS_MODE_NONE)
> > > > > +		return EXIT_SUCCESS;
> > > > > +
> > > > > +	passwd[0] = '\0';
> > > > > +
> > > > > +	stdin_fd = fileno(stdin);
> > > > > +
> > > > > +	if (!isatty(stdin_fd)) {
> > > > > +		error("tty needed for password input");
> > > > > +		return EXIT_FAILURE;
> > > > > +	}
> > > > > +
> > > > > +	tcgetattr(stdin_fd, &orig_term_flags);
> > > > > +	passwd_term_flags = orig_term_flags;
> > > > > +	passwd_term_flags.c_lflag &= ~ECHO;
> > > > > +	passwd_term_flags.c_lflag |= ECHONL;
> > > > > +
> > > > > +	if (tcsetattr(stdin_fd, TCSANOW, &passwd_term_flags)) {
> > > > > +		error("fail to hide password: %s", strerror(errno));
> > > > > +		return EXIT_FAILURE;
> > > > > +	}
> > > > > +
> > > > > +	printf("password: ");
> > > > > +	if (!fgets(passwd, sizeof(passwd), stdin)) {
> > > > > +		error("no password read");
> > > > > +		return EXIT_FAILURE;
> > > > > +	}
> > > > > +
> > > > > +	if (tcsetattr(fileno(stdin), TCSANOW, &orig_term_flags)) {
> > > > > +		error("fail to reset tty: %s", strerror(errno));
> > > > > +		return EXIT_FAILURE;
> > > > > +	}
> > > > > +
> > > > > +	passwd_sz = strlen(passwd);
> > > > > +	if (passwd_sz <= 0) {
> > > > > +		error("no password read");
> > > > > +		return EXIT_FAILURE;
> > > > > +	}
> > > > > +	if (passwd[passwd_sz - 1] == '\n') {
> > > > > +		passwd[passwd_sz - 1] = '\0';
> > > > > +		passwd_sz--;
> > > > > +	}
> > > > > +
> > > > > +	return ktls_set_psk_session(session, username,
> > > > > +				    (const unsigned char *)passwd, passwd_sz);
> > > > > +}
> > > > > +
> > > > > +int ktls_set_psk_session_from_keyfile(struct ktls_session *session,
> > > > > +				      const char *username,
> > > > > +				      const char *key_file)
> > > > > +{
> > > > > +	int rc = GNUTLS_E_SUCCESS;
> > > > > +	struct stat file_stat;
> > > > > +	size_t sz = 0;
> > > > > +	FILE *fp = NULL;
> > > > > +	gnutls_datum_t input = { NULL, 0UL };
> > > > > +	gnutls_datum_t output = { NULL, 0UL };
> > > > > +
> > > > > +	if (!session)
> > > > > +		goto cleanup;
> > > > > +
> > > > > +	if (session->tls_mode == KTLS_TLS_MODE_NONE)
> > > > > +		return EXIT_SUCCESS;
> > > > > +
> > > > > +	if (stat(key_file, &file_stat)) {
> > > > > +		error("fail to open keyfile: %s", strerror(errno));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	fp = fopen(key_file, "r");
> > > > > +	if (!fp) {
> > > > > +		error("fail to open keyfile: %s", strerror(errno));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	input.size = file_stat.st_size;
> > > > > +
> > > > > +	input.data = gnutls_malloc(input.size);
> > > > > +
> > > > > +	sz = fread(input.data, 1, input.size, fp);
> > > > > +
> > > > > +	if (sz != input.size) {
> > > > > +		error("fail to read PEM");
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	rc = gnutls_pem_base64_decode2(NULL, &input, &output);
> > > > > +	if (rc != GNUTLS_E_SUCCESS) {
> > > > > +		error("Error! fail to decode PEM: %s", gnutls_strerror(rc));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	return ktls_set_psk_session(session, username, output.data,
> > > > > +				    output.size);
> > > > > +
> > > > > +cleanup:
> > > > > +	return EXIT_FAILURE;
> > > > > +}
> > > > > +
> > > > > +struct ktls_session *ktls_create_session(bool is_sender)
> > > > > +{
> > > > > +	struct ktls_session *session = NULL;
> > > > > +
> > > > > +	session = (struct ktls_session *)malloc(sizeof(struct ktls_session));
> > > > > +	explicit_bzero(session, sizeof(*session));
> > > > > +
> > > > > +	gnutls_global_init();
> > > > > +
> > > > > +	session->role = is_sender ? GNUTLS_CLIENT : GNUTLS_SERVER;
> > > > > +	session->stage = KTLS_STAGE_NOT_HANDSHAKED;
> > > > > +
> > > > > +	gnutls_init(&session->session, session->role);
> > > > > +
> > > > > +	gnutls_global_set_log_level(bconf.verbose);
> > > > > +	gnutls_global_set_log_function(ktls_print_logs);
> > > > > +
> > > > > +	return session;
> > > > > +}
> > > > > +
> > > > > +void ktls_destroy_session(struct ktls_session *session)
> > > > > +{
> > > > > +	if (!session)
> > > > > +		return;
> > > > > +
> > > > > +	if (session->crt_cred)
> > > > > +		gnutls_certificate_free_credentials(session->crt_cred);
> > > > > +
> > > > > +	if (session->psk_cred_server)
> > > > > +		gnutls_psk_free_server_credentials(session->psk_cred_server);
> > > > > +
> > > > > +	if (session->psk_cred_client)
> > > > > +		gnutls_psk_free_client_credentials(session->psk_cred_client);
> > > > > +
> > > > > +	if (session->session) {
> > > > > +		if (session->stage == KTLS_STAGE_HAS_HANDSHAKED)
> > > > > +			gnutls_bye(session->session, GNUTLS_SHUT_RDWR);
> > > > > +		gnutls_deinit(session->session);
> > > > > +	}
> > > > > +
> > > > > +	gnutls_global_deinit();
> > > > > +
> > > > > +	explicit_bzero(session, sizeof(*session));
> > > > > +}
> > > > > +
> > > > > +static int ktls_connect_or_bind(int *sock, bool is_sender, int protocol,
> > > > > +				struct sockaddr *serv_addr, size_t serv_addr_sz)
> > > > > +{
> > > > > +	*sock = 0;
> > > > > +
> > > > > +	*sock = socket(protocol, SOCK_STREAM, 0);
> > > > > +	if (*sock == KTLS_INVALID_FD) {
> > > > > +		error("could not create socket: %s", strerror(errno));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	if (is_sender) {
> > > > > +		if (connect(*sock, serv_addr, serv_addr_sz)) {
> > > > > +			error("fail to connect to server: %s", strerror(errno));
> > > > > +			goto cleanup;
> > > > > +		}
> > > > > +		return EXIT_SUCCESS;
> > > > > +	}
> > > > > +
> > > > > +	if (setsockopt(*sock, SOL_SOCKET, SO_REUSEADDR, &(int){ 1 },
> > > > > +		       sizeof(int))) {
> > > > > +		error("fail to connect to server: %s", strerror(errno));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	if (bind(*sock, serv_addr, serv_addr_sz) || listen(*sock, 1)) {
> > > > > +		error("fail to serve as server: %s", strerror(errno));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	return EXIT_SUCCESS;
> > > > > +
> > > > > +cleanup:
> > > > > +	if (*sock >= 0)
> > > > > +		close(*sock);
> > > > > +	return EXIT_FAILURE;
> > > > > +}
> > > > > +
> > > > > +static int ktls_connect_domain(int *sock, bool is_sender, const char *host,
> > > > > +			       const uint16_t port)
> > > > > +{
> > > > > +	struct addrinfo hints = { 0 }, *res = NULL;
> > > > > +	int rc = 0;
> > > > > +	struct sockaddr_in addr4;
> > > > > +	struct sockaddr_in6 addr6;
> > > > > +
> > > > > +	memset(&hints, 0, sizeof(hints));
> > > > > +
> > > > > +	hints.ai_family = PF_UNSPEC;
> > > > > +	hints.ai_socktype = SOCK_STREAM;
> > > > > +	hints.ai_flags |= AI_CANONNAME;
> > > > > +
> > > > > +	if (getaddrinfo(host, NULL, &hints, &res)) {
> > > > > +		error("fail to get address info: %s", strerror(errno));
> > > > > +		return EXIT_FAILURE;
> > > > > +	}
> > > > > +
> > > > > +	while (res) {
> > > > > +		switch (res->ai_family) {
> > > > > +		case AF_INET:
> > > > > +			explicit_bzero(&addr4, sizeof(addr4));
> > > > > +			addr4.sin_addr =
> > > > > +				((struct sockaddr_in *)res->ai_addr)->sin_addr;
> > > > > +			addr4.sin_port = port;
> > > > > +			addr4.sin_family = res->ai_family;
> > > > > +			if (!ktls_connect_or_bind(
> > > > > +				    sock, is_sender, res->ai_family,
> > > > > +				    (struct sockaddr *)&addr4, sizeof(addr4))) {
> > > > > +				goto cleanup;
> > > > > +			}
> > > > > +			break;
> > > > > +		case AF_INET6:
> > > > > +			explicit_bzero(&addr6, sizeof(addr6));
> > > > > +			addr6.sin6_addr =
> > > > > +				((struct sockaddr_in6 *)res->ai_addr)->sin6_addr;
> > > > > +			addr6.sin6_port = port;
> > > > > +			addr6.sin6_family = res->ai_family;
> > > > > +			if (!ktls_connect_or_bind(
> > > > > +				    sock, is_sender, res->ai_family,
> > > > > +				    (struct sockaddr *)&addr6, sizeof(addr6))) {
> > > > > +				goto cleanup;
> > > > > +			}
> > > > > +			break;
> > > > > +		}
> > > > > +		res = res->ai_next;
> > > > > +	}
> > > > > +
> > > > > +	freeaddrinfo(res);
> > > > > +	return EXIT_FAILURE;
> > > > > +
> > > > > +cleanup:
> > > > > +	freeaddrinfo(res);
> > > > > +	return rc;
> > > > > +}
> > > > > +
> > > > > +static int ktls_connect_ip(int *sock, bool is_sender, const char *host,
> > > > > +			   const uint16_t port)
> > > > > +{
> > > > > +	struct sockaddr_in addr4;
> > > > > +	struct sockaddr_in6 addr6;
> > > > > +	struct sockaddr *serv_addr = NULL;
> > > > > +	size_t serv_addr_sz = 0;
> > > > > +	sa_family_t protol = AF_INET;
> > > > > +
> > > > > +	explicit_bzero(&addr4, sizeof(addr4));
> > > > > +	explicit_bzero(&addr6, sizeof(addr6));
> > > > > +
> > > > > +	if (inet_pton(AF_INET, host, &addr4.sin_addr) == 1) {
> > > > > +		serv_addr = (struct sockaddr *)&addr4;
> > > > > +		serv_addr_sz = sizeof(addr4);
> > > > > +		protol = addr4.sin_family = AF_INET;
> > > > > +		addr4.sin_port = port;
> > > > > +	}
> > > > > +
> > > > > +	if (!serv_addr && inet_pton(AF_INET6, host, &addr6.sin6_addr) == 1) {
> > > > > +		serv_addr = (struct sockaddr *)&addr6;
> > > > > +		serv_addr_sz = sizeof(addr6);
> > > > > +		protol = addr6.sin6_family = AF_INET6;
> > > > > +		addr6.sin6_port = port;
> > > > > +	}
> > > > > +
> > > > > +	if (!serv_addr)
> > > > > +		return KTLS_INVALID_FD;
> > > > > +
> > > > > +	return ktls_connect_or_bind(sock, is_sender, protol, serv_addr,
> > > > > +				    serv_addr_sz);
> > > > > +}
> > > > > +
> > > > > +int ktls_set_tls_mode(struct ktls_session *session, const char *mode)
> > > > > +{
> > > > > +	if (!session)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	if (!strcmp("none", mode))
> > > > > +		session->tls_mode = KTLS_TLS_MODE_NONE;
> > > > > +	else if (!strcmp("tls_12_128_gcm", mode))
> > > > > +		session->tls_mode = KTLS_TLS_12_128_GCM;
> > > > > +	else if (!strcmp("tls_13_128_gcm", mode))
> > > > > +		session->tls_mode = KTLS_TLS_13_128_GCM;
> > > > > +	else if (!strcmp("tls_12_256_gcm", mode))
> > > > > +		session->tls_mode = KTLS_TLS_12_256_GCM;
> > > > > +	else {
> > > > > +		error("unknown tls mode: %s", mode);
> > > > > +		return EXIT_FAILURE;
> > > > > +	}
> > > > > +	return EXIT_SUCCESS;
> > > > > +}
> > > > > +
> > > > > +#define INIT_GCM_WITH_MODE(V, X)                                               \
> > > > > +	{                                                                      \
> > > > > +		struct tls12_crypto_info_aes_gcm_##X crypto_info;              \
> > > > > +\
> > > > > +		crypto_info.info.version = TLS_##V##_VERSION;                  \
> > > > > +		crypto_info.info.cipher_type = TLS_CIPHER_AES_GCM_##X;         \
> > > > > +		memcpy(crypto_info.iv, seq_number,                             \
> > > > > +		       TLS_CIPHER_AES_GCM_##X##_IV_SIZE);                      \
> > > > > +		memcpy(crypto_info.rec_seq, seq_number,                        \
> > > > > +		       TLS_CIPHER_AES_GCM_##X##_REC_SEQ_SIZE);                 \
> > > > > +		if (cipher_key.size != TLS_CIPHER_AES_GCM_##X##_KEY_SIZE) {    \
> > > > > +			error("mismatch in send key size: %d != %d\n",         \
> > > > > +			      cipher_key.size,                                 \
> > > > > +			      TLS_CIPHER_AES_GCM_##X##_KEY_SIZE);              \
> > > > > +			goto cleanup;                                          \
> > > > > +		}                                                              \
> > > > > +		memcpy(crypto_info.key, cipher_key.data,                       \
> > > > > +		       TLS_CIPHER_AES_GCM_##X##_KEY_SIZE);                     \
> > > > > +		memcpy(crypto_info.salt, iv.data,                              \
> > > > > +		       TLS_CIPHER_AES_GCM_##X##_SALT_SIZE);                    \
> > > > > +		if (setsockopt(sock, SOL_TLS, is_sender ? TLS_TX : TLS_RX,     \
> > > > > +			       &crypto_info, sizeof(crypto_info))) {           \
> > > > > +			error("fail to set kernel tls: %s", strerror(errno));  \
> > > > > +			goto cleanup;                                          \
> > > > > +		}                                                              \
> > > > > +	}
> > > > > +
> > > > > +int ktls_handshake_tls(struct ktls_session *session, int sock)
> > > > > +{
> > > > > +	int rc = 0;
> > > > > +	bool is_sender = false;
> > > > > +	int handshake_retry = 3;
> > > > > +	char tls_priority_list[KTLS_MAX_PRIORITY_STRING_LENTH];
> > > > > +	const char *tls_priority_templ =
> > > > > +		"NONE:+MAC-ALL:+COMP-NULL:+SIGN-ALL:+GROUP-ALL:+ECDHE-PSK:+DHE-PSK:%s:%s";
> > > > > +	const char *tls_priority_ver_mode = NULL;
> > > > > +
> > > > > +	gnutls_datum_t mac_key;
> > > > > +	gnutls_datum_t iv;
> > > > > +	gnutls_datum_t cipher_key;
> > > > > +	unsigned char seq_number[8];
> > > > > +
> > > > > +	if (!session || !session->session)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	switch (session->tls_mode) {
> > > > > +	case KTLS_TLS_MODE_NONE:
> > > > > +		return EXIT_SUCCESS;
> > > > > +	case KTLS_TLS_12_128_GCM:
> > > > > +		tls_priority_ver_mode = "+VERS-TLS1.2:+AES-128-GCM";
> > > > > +		break;
> > > > > +	case KTLS_TLS_13_128_GCM:
> > > > > +		tls_priority_ver_mode = "+VERS-TLS1.3:+AES-128-GCM";
> > > > > +		break;
> > > > > +	case KTLS_TLS_12_256_GCM:
> > > > > +		tls_priority_ver_mode = "+VERS-TLS1.2:+AES-256-GCM";
> > > > > +		break;
> > > > > +	default:
> > > > > +		error("unknown tls mode");
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	is_sender = session->role == GNUTLS_CLIENT;
> > > > > +
> > > > > +	if (is_sender && session->psk_cred_client) {
> > > > > +		rc = gnutls_credentials_set(session->session, GNUTLS_CRD_PSK,
> > > > > +					    session->psk_cred_client);
> > > > > +		if (rc != GNUTLS_E_SUCCESS) {
> > > > > +			error("fail to set PSK for client: %s",
> > > > > +			      gnutls_strerror(rc));
> > > > > +			goto cleanup;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (!is_sender && session->psk_cred_server) {
> > > > > +		rc = gnutls_credentials_set(session->session, GNUTLS_CRD_PSK,
> > > > > +					    session->psk_cred_server);
> > > > > +		if (rc != GNUTLS_E_SUCCESS) {
> > > > > +			error("fail to set PSK for server: %s",
> > > > > +			      gnutls_strerror(rc));
> > > > > +			goto cleanup;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (session->crt_cred) {
> > > > > +		rc = gnutls_credentials_set(session->session,
> > > > > +					    GNUTLS_CRD_CERTIFICATE,
> > > > > +					    session->crt_cred);
> > > > > +
> > > > > +		if (rc == GNUTLS_E_SUCCESS) {
> > > > > +			error("fail to set certificate: %s",
> > > > > +			      gnutls_strerror(rc));
> > > > > +			goto cleanup;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	snprintf(tls_priority_list, KTLS_MAX_PRIORITY_STRING_LENTH,
> > > > > +		 tls_priority_templ,
> > > > > +		 is_sender ? "+CTYPE-CLI-ALL" : "+CTYPE-SRV-ALL",
> > > > > +		 tls_priority_ver_mode);
> > > > > +
> > > > > +	rc = gnutls_priority_set_direct(session->session, tls_priority_list,
> > > > > +					NULL);
> > > > > +	if (rc != GNUTLS_E_SUCCESS) {
> > > > > +		error("fail to set priority: %s", gnutls_strerror(rc));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	gnutls_transport_set_int(session->session, sock);
> > > > > +
> > > > > +	gnutls_handshake_set_timeout(session->session,
> > > > > +				     GNUTLS_DEFAULT_HANDSHAKE_TIMEOUT);
> > > > > +
> > > > > +	do {
> > > > > +		if (handshake_retry < 0) {
> > > > > +			error("exhaust retries on handshake");
> > > > > +			break;
> > > > > +		}
> > > > > +		rc = gnutls_handshake(session->session);
> > > > > +		handshake_retry--;
> > > > > +	} while (rc < 0 && !gnutls_error_is_fatal(rc));
> > > > > +
> > > > > +	if (gnutls_error_is_fatal(rc)) {
> > > > > +		error("fail on handshake: %s", gnutls_strerror(rc));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +	if (bconf.verbose > 0) {
> > > > > +		char *desc = gnutls_session_get_desc(session->session);
> > > > > +
> > > > > +		printf("TLS session info: %s\n", desc);
> > > > > +		gnutls_free(desc);
> > > > > +	}
> > > > > +
> > > > > +	session->stage = KTLS_STAGE_HAS_HANDSHAKED;
> > > > > +
> > > > > +	rc = gnutls_record_get_state(session->session, is_sender ? 0 : 1,
> > > > > +				     &mac_key, &iv, &cipher_key, seq_number);
> > > > > +	if (rc != GNUTLS_E_SUCCESS) {
> > > > > +		error("fail on retrieve TLS record: %s", gnutls_strerror(rc));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	if (setsockopt(sock, SOL_TCP, TCP_ULP, "tls", sizeof("tls"))) {
> > > > > +		error("fail to set kernel TLS on socket: %s", strerror(errno));
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	switch (session->tls_mode) {
> > > > > +	case KTLS_TLS_12_128_GCM:
> > > > > +		INIT_GCM_WITH_MODE(1_2, 128);
> > > > > +		break;
> > > > > +	case KTLS_TLS_13_128_GCM:
> > > > > +		INIT_GCM_WITH_MODE(1_3, 128);
> > > > > +		break;
> > > > > +	case KTLS_TLS_12_256_GCM:
> > > > > +		INIT_GCM_WITH_MODE(1_2, 256);
> > > > > +		break;
> > > > > +	default:
> > > > > +		error("unknown tls mode");
> > > > > +		goto cleanup;
> > > > > +	}
> > > > > +
> > > > > +	if (bconf.verbose > 0)
> > > > > +		fprintf(stderr, "ktls init done\n");
> > > > > +
> > > > > +	return EXIT_SUCCESS;
> > > > > +
> > > > > +cleanup:
> > > > > +	return EXIT_FAILURE;
> > > > > +}
> > > > > +
> > > > > +static int ktls_cp_datum(gnutls_datum_t *to, const gnutls_datum_t *from)
> > > > > +{
> > > > > +	if (!to || !from)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	to->size = from->size;
> > > > > +	to->data = (unsigned char *)gnutls_malloc(to->size);
> > > > > +	memmove(to->data, from->data, to->size);
> > > > > +
> > > > > +	return EXIT_SUCCESS;
> > > > > +}
> > > > > +
> > > > > +static int ktls_cmp_datum(const gnutls_datum_t *lhs, const gnutls_datum_t *rhs)
> > > > > +{
> > > > > +	if (!lhs && !rhs)
> > > > > +		return EXIT_SUCCESS;
> > > > > +
> > > > > +	if (!lhs || !rhs)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	if (lhs->size != rhs->size)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	return memcmp(lhs->data, rhs->data, lhs->size);
> > > > > +}
> > > > > +
> > > > > +static int ktls_set_datum(gnutls_datum_t *to, const unsigned char *from,
> > > > > +			  int from_size)
> > > > > +{
> > > > > +	if (!to || !from || !from_size)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	if (from_size < 0)
> > > > > +		from_size = strlen((const char *)from);
> > > > > +
> > > > > +	to->size = from_size;
> > > > > +	to->data = (unsigned char *)gnutls_malloc(to->size);
> > > > > +	memmove(to->data, from, from_size);
> > > > > +
> > > > > +	return EXIT_SUCCESS;
> > > > > +}
> > > > > +
> > > > > +static int tls_psk_client_callback(gnutls_session_t session,
> > > > > +				   gnutls_datum_t *username,
> > > > > +				   gnutls_datum_t *key)
> > > > > +{
> > > > > +	if (ktls_cp_datum(username, &ktls_psk_username) ||
> > > > > +	    ktls_cp_datum(key, &ktls_psk_key))
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	return EXIT_SUCCESS;
> > > > > +}
> > > > > +
> > > > > +static int tls_psk_server_callback(gnutls_session_t session,
> > > > > +				   const gnutls_datum_t *username,
> > > > > +				   gnutls_datum_t *key)
> > > > > +{
> > > > > +	if (ktls_cmp_datum(username, &ktls_psk_username) ||
> > > > > +	    ktls_cp_datum(key, &ktls_psk_key))
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	return EXIT_SUCCESS;
> > > > > +}
> > > > > +
> > > > > +int ktls_set_psk_session(struct ktls_session *session, const char *username,
> > > > > +			 const unsigned char *passwd, const size_t sz_passwd)
> > > > > +{
> > > > > +	bool is_sender = false;
> > > > > +	int rc = 0;
> > > > > +
> > > > > +	if (!session || !session->session)
> > > > > +		goto cleanup;
> > > > > +
> > > > > +	is_sender = session->role == GNUTLS_CLIENT;
> > > > > +
> > > > > +	if (!is_sender && !session->psk_cred_server) {
> > > > > +		rc = gnutls_psk_allocate_server_credentials(
> > > > > +			&session->psk_cred_server);
> > > > > +		if (rc != GNUTLS_E_SUCCESS) {
> > > > > +			error("fail on set psk for server: %s",
> > > > > +			      gnutls_strerror(rc));
> > > > > +			goto cleanup;
> > > > > +		}
> > > > > +		gnutls_psk_set_server_credentials_function2(
> > > > > +			session->psk_cred_server, tls_psk_server_callback);
> > > > > +	}
> > > > > +
> > > > > +	if (is_sender && !session->psk_cred_client) {
> > > > > +		rc = gnutls_psk_allocate_client_credentials(
> > > > > +			&session->psk_cred_client);
> > > > > +		if (rc != GNUTLS_E_SUCCESS) {
> > > > > +			error("fail on set psk for client: %s",
> > > > > +			      gnutls_strerror(rc));
> > > > > +			goto cleanup;
> > > > > +		}
> > > > > +		gnutls_psk_set_client_credentials_function2(
> > > > > +			session->psk_cred_client, tls_psk_client_callback);
> > > > > +	}
> > > > > +
> > > > > +	if (!ktls_psk_key.size)
> > > > > +		gnutls_free(ktls_psk_key.data);
> > > > > +
> > > > > +	if (!ktls_psk_username.size)
> > > > > +		gnutls_free(ktls_psk_username.data);
> > > > > +
> > > > > +	if (ktls_set_datum(&ktls_psk_username, (const unsigned char *)username,
> > > > > +			   -1) ||
> > > > > +	    ktls_set_datum(&ktls_psk_key, passwd, sz_passwd))
> > > > > +		goto cleanup;
> > > > > +
> > > > > +	return EXIT_SUCCESS;
> > > > > +
> > > > > +cleanup:
> > > > > +	return EXIT_FAILURE;
> > > > > +}
> > > > > +
> > > > > +int ktls_create_sock_oneshot(struct ktls_session *session, const char *host,
> > > > > +			     const char *port)
> > > > > +{
> > > > > +	int sock = 0;
> > > > > +	int nport = 0;
> > > > > +	bool is_sender;
> > > > > +
> > > > > +	if (!session || !session->session)
> > > > > +		return EXIT_FAILURE;
> > > > > +
> > > > > +	is_sender = session->role == GNUTLS_CLIENT;
> > > > > +
> > > > > +	nport = atoi(port);
> > > > > +
> > > > > +	if (nport >= 0 && nport <= 65535)
> > > > > +		nport = htons((uint16_t)nport);
> > > > > +
> > > > > +	if (ktls_connect_ip(&sock, is_sender, host, (uint16_t)nport))
> > > > > +		if (ktls_connect_domain(&sock, is_sender, host, nport))
> > > > > +			goto cleanup;
> > > > > +
> > > > > +	if (!is_sender) {
> > > > > +		int accepted_sock = KTLS_INVALID_FD;
> > > > > +
> > > > > +		accepted_sock = accept(sock, (struct sockaddr *)NULL, NULL);
> > > > > +		close(sock);
> > > > > +		sock = accepted_sock;
> > > > > +	}
> > > > > +
> > > > > +	if (ktls_handshake_tls(session, sock))
> > > > > +		goto cleanup;
> > > > > +
> > > > > +	return sock;
> > > > > +
> > > > > +cleanup:
> > > > > +	close(sock);
> > > > > +	return KTLS_INVALID_FD;
> > > > > +}
> > > > > diff --git a/common/ktls.h b/common/ktls.h
> > > > > new file mode 100644
> > > > > index 00000000..d744e18e
> > > > > --- /dev/null
> > > > > +++ b/common/ktls.h
> > > > > @@ -0,0 +1,57 @@
> > > > > +/*
> > > > > + * Copyright (C) 2020 Sheng Mao.  All rights reserved.
> > > > > + *
> > > > > + * This program is free software; you can redistribute it and/or
> > > > > + * modify it under the terms of the GNU General Public
> > > > > + * License v2 as published by the Free Software Foundation.
> > > > > + *
> > > > > + * This program is distributed in the hope that it will be useful,
> > > > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > > > + * General Public License for more details.
> > > > > + */
> > > > > +
> > > > > +#ifndef __BTRFS_KTLS_H__
> > > > > +#define __BTRFS_KTLS_H__
> > > > > +
> > > > > +#include <stdbool.h>
> > > > > +#include <stddef.h>
> > > > > +
> > > > > +#ifdef __cplusplus
> > > > > +extern "C" {
> > > > > +#endif
> > > > > +
> > > > > +struct ktls_session;
> > > > > +
> > > > > +enum { KTLS_INVALID_FD = -1 };
> > > > > +
> > > > > +struct ktls_session *ktls_create_session(bool is_sender);
> > > > > +void ktls_destroy_session(struct ktls_session *session);
> > > > > +
> > > > > +// ktls_set_psk_session sets PSK (pre-shared key). username is NULL-terminated
> > > > > +// string; passwd is sized string. Memory of both strings are managed by
> > > > > +// caller. currently, this API only allows to set PSK before calling
> > > > > +// ktls_handshake_*()
> > > > > +int ktls_set_psk_session(struct ktls_session *session, const char *username,
> > > > > +			 const unsigned char *passwd, const size_t sz_passwd);
> > > > > +
> > > > > +int ktls_set_psk_session_from_password_prompt(struct ktls_session *session,
> > > > > +					      const char *username);
> > > > > +
> > > > > +int ktls_set_psk_session_from_keyfile(struct ktls_session *session,
> > > > > +				      const char *username,
> > > > > +				      const char *key_file);
> > > > > +
> > > > > +int ktls_set_tls_mode(struct ktls_session *session, const char *mode);
> > > > > +
> > > > > +int ktls_handshake_tls(struct ktls_session *session, int sock);
> > > > > +
> > > > > +// ktls_create_sock_oneshot returns a sock fd on success.
> > > > > +int ktls_create_sock_oneshot(struct ktls_session *session, const char *host,
> > > > > +			     const char *port);
> > > > > +
> > > > > +#ifdef __cplusplus
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > > +#endif // __BTRFS_KTLS_H__
> > > > > -- 
> > > > > 2.29.2
> > > > 
> > > > 
> > 
> 
> 

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="io_send_to_sock.patch"

diff --git a/cmds/send.c b/cmds/send.c
index 006eb3cc..eaee0eac 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -246,6 +246,10 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 	void *t_err = NULL;
 	int subvol_fd = -1;
 	int pipefd[2] = {-1, -1};
+	struct stat out_fd_stat;
+	bool is_sock = false;
+
+	memset(&io_send, 0, sizeof(io_send));
 
 	subvol_fd = openat(send->mnt_fd, subvol, O_RDONLY | O_NOATIME);
 	if (subvol_fd < 0) {
@@ -254,24 +258,35 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 		goto out;
 	}
 
-	ret = pipe(pipefd);
-	if (ret < 0) {
+	if (fstat(send->dump_fd, &out_fd_stat) < 0) {
 		ret = -errno;
-		error("pipe failed: %m");
+		error("fail to get out fd's stat: %s", strerror(errno));
 		goto out;
 	}
 
-	memset(&io_send, 0, sizeof(io_send));
-	io_send.send_fd = pipefd[1];
-	send->send_fd = pipefd[0];
+	is_sock = (out_fd_stat.st_mode & S_IFMT) == S_IFSOCK;
 
-	if (!ret)
-		ret = pthread_create(&t_read, NULL, read_sent_data, send);
-	if (ret) {
-		ret = -ret;
-		errno = -ret;
-		error("thread setup failed: %m");
-		goto out;
+	if (!is_sock) {
+		ret = pipe(pipefd);
+		if (ret < 0) {
+			ret = -errno;
+			error("pipe failed: %m");
+			goto out;
+		}
+		io_send.send_fd = pipefd[1];
+		send->send_fd = pipefd[0];
+
+		if (!ret)
+			ret = pthread_create(&t_read, NULL, read_sent_data,
+					     send);
+		if (ret) {
+			ret = -ret;
+			errno = -ret;
+			error("thread setup failed: %m");
+			goto out;
+		}
+	} else {
+		io_send.send_fd = send->dump_fd;
 	}
 
 	io_send.flags = flags;
@@ -294,24 +309,26 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 	if (bconf.verbose > 1)
 		fprintf(stderr, "BTRFS_IOC_SEND returned %d\n", ret);
 
-	if (bconf.verbose > 1)
-		fprintf(stderr, "joining genl thread\n");
+	if (!is_sock) {
+		if (bconf.verbose > 1)
+			fprintf(stderr, "joining genl thread\n");
 
-	close(pipefd[1]);
-	pipefd[1] = -1;
+		close(pipefd[1]);
+		pipefd[1] = -1;
 
-	ret = pthread_join(t_read, &t_err);
-	if (ret) {
-		ret = -ret;
-		errno = -ret;
-		error("pthread_join failed: %m");
-		goto out;
-	}
-	if (t_err) {
-		ret = (long int)t_err;
-		error("failed to process send stream, ret=%ld (%s)",
-				(long int)t_err, strerror(-ret));
-		goto out;
+		ret = pthread_join(t_read, &t_err);
+		if (ret) {
+			ret = -ret;
+			errno = -ret;
+			error("pthread_join failed: %m");
+			goto out;
+		}
+		if (t_err) {
+			ret = (long int)t_err;
+			error("failed to process send stream, ret=%ld (%s)",
+			      (long int)t_err, strerror(-ret));
+			goto out;
+		}
 	}
 
 	ret = 0;
diff --git a/common/ktls.c b/common/ktls.c
index a4d670e3..5794916d 100644
--- a/common/ktls.c
+++ b/common/ktls.c
@@ -662,6 +662,36 @@ cleanup:
 	return EXIT_FAILURE;
 }
 
+static int ktls_enlarge_buffer(int sock, bool is_sender)
+{
+	FILE *wmem = NULL;
+	int min_buf = 0, dft_buf = 0, max_buf = 0;
+	int ret = EXIT_FAILURE;
+
+	if (sock < 0)
+		goto cleanup;
+
+	wmem = fopen("/proc/sys/net/ipv4/tcp_wmem", "r");
+	if (!wmem)
+		goto cleanup;
+
+	if (fscanf(wmem, "%d%d%d", &min_buf, &dft_buf, &max_buf) != 3) {
+		error("cannot get buffer size");
+		goto cleanup;
+	}
+
+	setsockopt(sock, SOL_SOCKET, SO_SNDBUF, (void *)&min_buf,
+		   sizeof(min_buf));
+
+	ret = EXIT_SUCCESS;
+
+cleanup:
+	if (wmem)
+		fclose(wmem);
+
+	return ret;
+}
+
 int ktls_create_sock_oneshot(struct ktls_session *session, const char *host,
 			     const char *port)
 {
@@ -691,6 +721,8 @@ int ktls_create_sock_oneshot(struct ktls_session *session, const char *host,
 		sock = accepted_sock;
 	}
 
+	ktls_enlarge_buffer(sock, is_sender);
+
 	if (ktls_handshake_tls(session, sock))
 		goto cleanup;
 

--cWoXeonUoKmBZSoM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="large_pipe_buf.patch"

diff --git a/cmds/send.c b/cmds/send.c
index 006eb3cc..78315cfd 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -246,6 +246,7 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 	void *t_err = NULL;
 	int subvol_fd = -1;
 	int pipefd[2] = {-1, -1};
+	int pipesize = 1048576;
 
 	subvol_fd = openat(send->mnt_fd, subvol, O_RDONLY | O_NOATIME);
 	if (subvol_fd < 0) {
@@ -265,8 +266,11 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 	io_send.send_fd = pipefd[1];
 	send->send_fd = pipefd[0];
 
-	if (!ret)
+	if (!ret) {
+		fcntl(pipefd[1], F_SETPIPE_SZ, &pipesize);
+		fcntl(pipefd[1], F_SETPIPE_SZ, &pipesize);
 		ret = pthread_create(&t_read, NULL, read_sent_data, send);
+	}
 	if (ret) {
 		ret = -ret;
 		errno = -ret;

--cWoXeonUoKmBZSoM--
