Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96FB1CCC9D
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 May 2020 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgEJRWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 May 2020 13:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728926AbgEJRWH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 May 2020 13:22:07 -0400
X-Greylist: delayed 19781 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 May 2020 10:22:06 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB0C061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 10 May 2020 10:22:06 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 14C659C3DD; Sun, 10 May 2020 18:22:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589131323;
        bh=umom0ROpFxqQX+QfCcmZVYClZ8XEftB1rAHnuJVqFyo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ern9WKalB8qtBDIr8tG+Z5REoEK+l1Rdcaje7kAQhcYD7Olv46WrBc/boiAt/n6XI
         FE0JcKpwtfaZ6FjvrME/0ExwZAwVKPdPucCr4N5H+RDllQxqu21zymWE24Q6iqzNsP
         juDlpkZA6YxaXCi26pqhjnV4l2TDltd4AEyMqQ/15GG4h0E1FWvNGA+WLzQ3Mcu6UP
         xdJjX2aVyj2Cs+zJk3YWac+cFpQbue++kO6ywlt13Nig7F3aL/lMFh2TJZCpafRW1G
         BJGiG6gQXwlMRpiOCWWW+9F90zGZfnTh3Wj5+8bFlT3KzqA3CoSVu/L2h2Q5teY175
         V9048JElT5Lbg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 28EC69B9D5;
        Sun, 10 May 2020 18:21:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1589131317;
        bh=umom0ROpFxqQX+QfCcmZVYClZ8XEftB1rAHnuJVqFyo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PkBqoATTZ6S6kZNaxs9rJMafTaDyEMPV55AK2+7SrwmRZiUvwhDCfUMBJh3Cibemy
         pYRsBSEkFZavHqLUfjPYcVtT2Mc3+typGAvY8cG8PQn22YDdc+17TmWrBv/3DBQ2xx
         2SY5ml1uT0PE6ZWGKoOsWJDMO1A/Gw9SgfjyATyivfiVUSpOndQ+LO67mmiWQScc8b
         DT0Q9jamw6aJYWpJO2uOoWHHckS7AeY0juFC/6Th52UFNp4nB9FAsUBtrI/ru5rV5D
         HCfvVBdrH2FD9gSlA7Itqqk01Sj0EVavckri5wlVGqzZgcUGGVNGkGrhYPtQ1XfRbB
         6KMq+xAxDWMlw==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id B9139102237;
        Sun, 10 May 2020 18:21:56 +0100 (BST)
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrew Pam <andrew@sericyb.com.au>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au>
 <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au>
 <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au>
 <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au>
 <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
 <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au>
 <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
 <CAJCQCtTcwGm8WF+AKX4CBBRQ2vYjj-ZPx66So3Qxvp8Y9j5rJg@mail.gmail.com>
 <e2a308d2-690d-e6dd-8166-c56765aef54e@cobb.uk.net>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <0cd04c91-3a44-32d8-79e7-a15b8642c134@cobb.uk.net>
Date:   Sun, 10 May 2020 18:21:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e2a308d2-690d-e6dd-8166-c56765aef54e@cobb.uk.net>
Content-Type: multipart/mixed;
 boundary="------------0BF3D8A7EDC212556CD35A9A"
Content-Language: en-GB
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------0BF3D8A7EDC212556CD35A9A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 10/05/2020 12:52, Graham Cobb wrote:
> On 10/05/2020 02:14, Chris Murphy wrote:
>> I don't know how the kernel and user space communicate scrub progress.
>> I don't see anything in sysfs.
> 
> I did some work on btrfs-scrub a while ago to fix a bug in the way
> last_physical was being saved between cancel and restore.
> 
> If I remember correctly, the way this works is that the scrub process
> receives stats about the scrub progress directly from the kernel on a
> socket it creates in /var/lib/btrfs, then writes updated stats into a
> file in /var/lib/btrfs/scrub.status.<UUID> to share with scrub status
> and keep a record. At the end of the scrub, the final stats are provided
> by the kernel into a buffer provided in the ioctl which are also then
> used to update the scrub.status file.

Unfortunately my memory is rubbish! I have just looked at the code to
remind myself.

The scrub process gets stats from the kernel using a
BTRFS_IOC_SCRUB_PROGRESS ioctl (one for each device).

It uses this to update the status file and also sends the stats to any
listeners on the socket.

btrfs scrub status reads the data from the socket if it exists (i.e. the
scrub process is still running), otherwise it reads it from the data
file (for a scrub which has finished or been cancelled).

It might be worth you making a small logging change to progress_one_dev
to watch the value of last_physical exactly as received from the kernel
during the scrub. I have attached a small patch.

--------------0BF3D8A7EDC212556CD35A9A
Content-Type: text/x-patch;
 name="scrub.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="scrub.c.patch"

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 9fe59822..48d76852 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -902,6 +902,8 @@ static void *progress_one_dev(void *ctx)
 	struct scrub_progress *sp = ctx;
 
 	sp->ret = ioctl(sp->fd, BTRFS_IOC_SCRUB_PROGRESS, &sp->scrub_args);
+	fprintf(stderr, "NOTE: device %lld last_physical=%lld\n", sp->scrub_args.devid, sp->scrub_args.progress.last_physical);
+
 	sp->ioctl_errno = errno;
 
 	return NULL;
@@ -1784,7 +1786,8 @@ static int cmd_scrub_status(const struct cmd_struct *cmd, int argc, char **argv)
 			err = 1;
 			goto out;
 		}
-	}
+		fputs("NOTE: Reading progress from status file \n", stderr);
+	} else { fputs("NOTE: Reading progress from socket \n", stderr); }
 
 	if (fdres >= 0) {
 		past_scrubs = scrub_read_file(fdres, 1);

--------------0BF3D8A7EDC212556CD35A9A--
