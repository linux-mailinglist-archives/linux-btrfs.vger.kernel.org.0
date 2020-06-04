Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9A1EE1B7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jun 2020 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgFDJp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Jun 2020 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFDJp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Jun 2020 05:45:56 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79D3C03E96D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Jun 2020 02:45:55 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id r11so3151928vsj.5
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jun 2020 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ed6/DSkkgQ+D6n9H6jTJ2oVisHsgcWSIv3L2gK/1Bro=;
        b=hbUqIoYr+Lj3JZ2tof+w8uyeSNA3RiOkGLUhOjxx1WeE4NKKGLDUC6qzndI2ryqC9R
         SB7FMHc3z2lXIboD7lJhTaYzTxkBDMgL64l/P+gMlyfsdXMFH2AKi7xVIDaqEfmFC9UV
         khZrfIxFWp+GmLafBNyuKVbovnuCuMa5m+j9q0DkW8pF61iTJwE4MVxMLvivOurOyO9G
         y6CJxjYMMzdDpdWEpB4qOoFK4dMr/7cMrFdkniNk5hkD+iwVibWN3B2W1SgqFaYzX5r2
         XEJrvjkQyeT4zzRVqg7TBnlITPGHJmDFBjN/tH/7lXuX6A20DOxd7HR27/Gg/xBpBdqT
         PerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ed6/DSkkgQ+D6n9H6jTJ2oVisHsgcWSIv3L2gK/1Bro=;
        b=iV19Pn4ECwoelQ8nQPdm96QCZrMzhG2pSA2+l3O3I8/i3h8ZCIsJ8eHjSsew35HJdb
         cQzGbzB62S5FYlP+MIUo/7ruiQswA+bN62i2to99qTTmIbXIHqCMWx7cHqD7m1L5i/uC
         YpHF+QvzIqCvMUor7cLu7qtz3XLXH7LfhU81yGIuxT1R6vpf8vjVQMVHgB9oD579tV93
         KTYWaqLl+tmRCvdWT192Cmgm4Two253VOuKWTPF3uDgqqQJstCacSFi2WPGvmAClaTcA
         ZVQcOJTJtNlBMUZunEEJ6bevBxSlooBciXFx3GyaAgtciektxoSZE3U8Ea6vVsX8DPEM
         /fXg==
X-Gm-Message-State: AOAM532cHDqqYJp1vncXBAfh3++ZQOaRVM0p//FFHLBVvZ+BMqLiES3z
        bC3H/ploZl03ZA7RUOqm//A7PwFETtVcla6hdTY=
X-Google-Smtp-Source: ABdhPJw0jI0waNZN/vUvB8aGOuIcWQyoDDZaB6BSZagFOlWdqwXuHKbcTCYHos6+kqJeri2YTuCHbeRlwikL+NoL1Wc=
X-Received: by 2002:a67:1c04:: with SMTP id c4mr2814897vsc.133.1591263954198;
 Thu, 04 Jun 2020 02:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <CABT3_pzBdRqe7SRBptM1E5MPJfwEGF6=YBovmZdj1Vxjs21iNQ@mail.gmail.com>
 <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com>
In-Reply-To: <5fdc798c-c8eb-b4cf-b247-e70f5fd49fc4@gmx.com>
From:   Thorsten Rehm <thorsten.rehm@gmail.com>
Date:   Thu, 4 Jun 2020 11:45:42 +0200
Message-ID: <CABT3_pwG1CrxYBDXTzQZLVGYkLoxKpexEdyJWnm_7TCaskbOeA@mail.gmail.com>
Subject: Re: corrupt leaf; invalid root item size
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for you answer.
I've just updated my system, did a reboot and it's running with a
5.6.0-2-amd64 now.
So, this is how my kern.log looks like, just right after the start:

--- snip ---
$ grep 'corrupt leaf' /var/log/kern.log
Jun  4 11:17:31 foo kernel: [   17.318906] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D55352561664 slot=3D32, invalid root
item size, have 239 expect 439
Jun  4 11:17:31 foo kernel: [   18.481280] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D29552640 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:17:31 foo kernel: [   19.384536] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D29978624 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:17:52 foo kernel: [   53.325803] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D33017856 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:17:59 foo kernel: [   60.297490] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D33316864 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:00 foo kernel: [   61.036287] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D34476032 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:02 foo kernel: [   63.935084] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D34799616 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:03 foo kernel: [   64.655925] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D36147200 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:08 foo kernel: [   69.039268] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:09 foo kernel: [   70.117411] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D38862848 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:15 foo kernel: [   76.437708] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D39235584 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:17 foo kernel: [   78.742254] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D40624128 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:22 foo kernel: [   83.297564] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D40849408 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:23 foo kernel: [   84.091532] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D41259008 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:24 foo kernel: [   85.020701] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D41410560 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:25 foo kernel: [   86.131558] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D41639936 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:26 foo kernel: [   87.072399] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D41832448 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:27 foo kernel: [   88.541477] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D41975808 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:28 foo kernel: [   89.115634] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D42217472 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:29 foo kernel: [   90.103851] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D42438656 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:29 foo kernel: [   90.809648] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D42627072 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:30 foo kernel: [   91.440182] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D42909696 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:31 foo kernel: [   92.340470] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D43171840 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:31 foo kernel: [   92.870607] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D43511808 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:33 foo kernel: [   94.219649] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D43868160 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:33 foo kernel: [   94.969616] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D44179456 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:35 foo kernel: [   96.562527] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D44670976 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:36 foo kernel: [   97.129857] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D44900352 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:36 foo kernel: [   97.748836] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D44998656 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:37 foo kernel: [   98.391906] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D45289472 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:38 foo kernel: [   99.089307] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D45383680 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:38 foo kernel: [   99.461716] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D45555712 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:39 foo kernel: [  100.158759] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D45752320 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:39 foo kernel: [  100.740379] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D46080000 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:40 foo kernel: [  101.369630] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D46178304 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:40 foo kernel: [  101.800933] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D46428160 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:41 foo kernel: [  102.498185] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D49192960 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:44 foo kernel: [  105.790049] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D49565696 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:46 foo kernel: [  107.411126] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D49868800 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:46 foo kernel: [  107.801978] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D49987584 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:47 foo kernel: [  108.270144] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D51200000 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:54 foo kernel: [  115.373156] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D51433472 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:56 foo kernel: [  117.062892] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D51310592 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:56 foo kernel: [  117.535135] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D51961856 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:57 foo kernel: [  118.001052] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D51216384 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:57 foo kernel: [  118.683809] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D52215808 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:59 foo kernel: [  120.062056] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D52436992 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:18:59 foo kernel: [  120.561448] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D52490240 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:00 foo kernel: [  121.304476] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D52662272 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:00 foo kernel: [  121.950378] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D54153216 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:03 foo kernel: [  124.896498] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D54390784 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:04 foo kernel: [  125.583191] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D54599680 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:07 foo kernel: [  128.121654] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D55197696 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:07 foo kernel: [  128.598669] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D56119296 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:12 foo kernel: [  133.197514] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D56369152 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:13 foo kernel: [  134.963297] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D56881152 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:14 foo kernel: [  135.356174] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D57028608 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:14 foo kernel: [  135.820369] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D57270272 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:16 foo kernel: [  137.022879] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D57438208 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:16 foo kernel: [  137.516500] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D57614336 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:17 foo kernel: [  138.105293] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D57716736 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:17 foo kernel: [  138.523561] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D57962496 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:18 foo kernel: [  139.495373] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D58118144 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:18 foo kernel: [  139.997187] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D58273792 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:19 foo kernel: [  140.273888] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D58449920 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:19 foo kernel: [  140.714191] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D58843136 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:20 foo kernel: [  141.905748] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D59174912 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:21 foo kernel: [  142.654312] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D59387904 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:22 foo kernel: [  143.054925] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D59469824 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:22 foo kernel: [  143.475570] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D59674624 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:23 foo kernel: [  144.235453] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D59731968 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:23 foo kernel: [  144.754629] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D59830272 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:24 foo kernel: [  145.159837] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D59924480 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:24 foo kernel: [  145.726221] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D60141568 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:25 foo kernel: [  146.585324] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D60342272 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:26 foo kernel: [  147.087844] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D60502016 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:26 foo kernel: [  147.484708] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D60678144 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:26 foo kernel: [  147.797383] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D60952576 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:27 foo kernel: [  148.766842] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D61206528 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:28 foo kernel: [  149.214399] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D61345792 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:28 foo kernel: [  149.524317] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D61493248 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:28 foo kernel: [  149.900128] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D61706240 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:30 foo kernel: [  151.036028] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D62074880 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:30 foo kernel: [  151.962081] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D62574592 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:32 foo kernel: [  153.292089] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D62902272 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:33 foo kernel: [  154.005536] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D63176704 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:33 foo kernel: [  154.385265] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D63303680 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:33 foo kernel: [  154.663472] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D63455232 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:33 foo kernel: [  154.964766] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D63557632 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:34 foo kernel: [  155.263943] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D63688704 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:34 foo kernel: [  155.523667] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D63827968 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:34 foo kernel: [  155.863992] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D63963136 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:35 foo kernel: [  156.121666] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D64106496 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:35 foo kernel: [  156.434339] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D64598016 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:37 foo kernel: [  158.309759] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D64815104 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:37 foo kernel: [  158.956640] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D65032192 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:38 foo kernel: [  159.275606] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D65220608 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:38 foo kernel: [  159.655287] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D65429504 slot=3D32, invalid root item
size, have 239 expect 439
Jun  4 11:19:39 foo kernel: [  160.017161] BTRFS critical (device
dm-0): corrupt leaf: root=3D1 block=3D65576960 slot=3D32, invalid root item
size, have 239 expect 439
[...]
--- snap ---

There are too many blocks. I just picked three randomly:

=3D=3D=3D Block 33017856 =3D=3D=3D
$ btrfs ins dump-tree -b 33017856 /dev/dm-0
btrfs-progs v5.6
leaf 33017856 items 51 free space 17 generation 24749502 owner FS_TREE
leaf 33017856 flags 0x1(WRITTEN) backref revision 1
fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
        item 0 key (4000670 EXTENT_DATA 1572864) itemoff 3942 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1568768 nr 4096 ram 4194304
                extent compression 0 (none)
        item 1 key (4000670 EXTENT_DATA 1576960) itemoff 3889 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1121533952 nr 4096
                extent data offset 0 nr 20480 ram 20480
                extent compression 2 (lzo)
        item 2 key (4000670 EXTENT_DATA 1597440) itemoff 3836 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1593344 nr 4096 ram 4194304
                extent compression 0 (none)
        item 3 key (4000670 EXTENT_DATA 1601536) itemoff 3783 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1122422784 nr 4096
                extent data offset 0 nr 8192 ram 8192
                extent compression 2 (lzo)
        item 4 key (4000670 EXTENT_DATA 1609728) itemoff 3730 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1605632 nr 4096 ram 4194304
                extent compression 0 (none)
        item 5 key (4000670 EXTENT_DATA 1613824) itemoff 3677 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1122488320 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 6 key (4000670 EXTENT_DATA 1617920) itemoff 3624 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1613824 nr 4096 ram 4194304
                extent compression 0 (none)
        item 7 key (4000670 EXTENT_DATA 1622016) itemoff 3571 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1122660352 nr 4096
                extent data offset 0 nr 49152 ram 49152
                extent compression 2 (lzo)
        item 8 key (4000670 EXTENT_DATA 1671168) itemoff 3518 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1667072 nr 4096 ram 4194304
                extent compression 0 (none)
        item 9 key (4000670 EXTENT_DATA 1675264) itemoff 3465 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1122840576 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 10 key (4000670 EXTENT_DATA 1679360) itemoff 3412 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1675264 nr 4096 ram 4194304
                extent compression 0 (none)
        item 11 key (4000670 EXTENT_DATA 1683456) itemoff 3359 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1122869248 nr 4096
                extent data offset 0 nr 28672 ram 28672
                extent compression 2 (lzo)
        item 12 key (4000670 EXTENT_DATA 1712128) itemoff 3306 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1708032 nr 8192 ram 4194304
                extent compression 0 (none)
        item 13 key (4000670 EXTENT_DATA 1720320) itemoff 3253 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1123074048 nr 4096
                extent data offset 0 nr 12288 ram 12288
                extent compression 2 (lzo)
        item 14 key (4000670 EXTENT_DATA 1732608) itemoff 3200 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1728512 nr 8192 ram 4194304
                extent compression 0 (none)
        item 15 key (4000670 EXTENT_DATA 1740800) itemoff 3147 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1123078144 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 16 key (4000670 EXTENT_DATA 1744896) itemoff 3094 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1740800 nr 4096 ram 4194304
                extent compression 0 (none)
        item 17 key (4000670 EXTENT_DATA 1748992) itemoff 3041 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1123119104 nr 4096
                extent data offset 0 nr 20480 ram 20480
                extent compression 2 (lzo)
        item 18 key (4000670 EXTENT_DATA 1769472) itemoff 2988 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1765376 nr 4096 ram 4194304
                extent compression 0 (none)
        item 19 key (4000670 EXTENT_DATA 1773568) itemoff 2935 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1123926016 nr 4096
                extent data offset 0 nr 16384 ram 16384
                extent compression 2 (lzo)
        item 20 key (4000670 EXTENT_DATA 1789952) itemoff 2882 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1785856 nr 4096 ram 4194304
                extent compression 0 (none)
        item 21 key (4000670 EXTENT_DATA 1794048) itemoff 2829 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1124212736 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 22 key (4000670 EXTENT_DATA 1798144) itemoff 2776 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1794048 nr 8192 ram 4194304
                extent compression 0 (none)
        item 23 key (4000670 EXTENT_DATA 1806336) itemoff 2723 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1124581376 nr 4096
                extent data offset 0 nr 53248 ram 53248
                extent compression 2 (lzo)
        item 24 key (4000670 EXTENT_DATA 1859584) itemoff 2670 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1855488 nr 4096 ram 4194304
                extent compression 0 (none)
        item 25 key (4000670 EXTENT_DATA 1863680) itemoff 2617 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1125728256 nr 4096
                extent data offset 0 nr 12288 ram 12288
                extent compression 2 (lzo)
        item 26 key (4000670 EXTENT_DATA 1875968) itemoff 2564 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1871872 nr 4096 ram 4194304
                extent compression 0 (none)
        item 27 key (4000670 EXTENT_DATA 1880064) itemoff 2511 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1125928960 nr 4096
                extent data offset 0 nr 20480 ram 20480
                extent compression 2 (lzo)
        item 28 key (4000670 EXTENT_DATA 1900544) itemoff 2458 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1896448 nr 4096 ram 4194304
                extent compression 0 (none)
        item 29 key (4000670 EXTENT_DATA 1904640) itemoff 2405 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1126227968 nr 4096
                extent data offset 0 nr 20480 ram 20480
                extent compression 2 (lzo)
        item 30 key (4000670 EXTENT_DATA 1925120) itemoff 2352 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1921024 nr 8192 ram 4194304
                extent compression 0 (none)
        item 31 key (4000670 EXTENT_DATA 1933312) itemoff 2299 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1126502400 nr 4096
                extent data offset 0 nr 8192 ram 8192
                extent compression 2 (lzo)
        item 32 key (4000670 EXTENT_DATA 1941504) itemoff 2246 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1937408 nr 4096 ram 4194304
                extent compression 0 (none)
        item 33 key (4000670 EXTENT_DATA 1945600) itemoff 2193 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1129639936 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 34 key (4000670 EXTENT_DATA 1949696) itemoff 2140 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1945600 nr 4096 ram 4194304
                extent compression 0 (none)
        item 35 key (4000670 EXTENT_DATA 1953792) itemoff 2087 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1130332160 nr 4096
                extent data offset 0 nr 8192 ram 8192
                extent compression 2 (lzo)
        item 36 key (4000670 EXTENT_DATA 1961984) itemoff 2034 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1957888 nr 4096 ram 4194304
                extent compression 0 (none)
        item 37 key (4000670 EXTENT_DATA 1966080) itemoff 1981 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1140027392 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 38 key (4000670 EXTENT_DATA 1970176) itemoff 1928 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1966080 nr 4096 ram 4194304
                extent compression 0 (none)
        item 39 key (4000670 EXTENT_DATA 1974272) itemoff 1875 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1143840768 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 40 key (4000670 EXTENT_DATA 1978368) itemoff 1822 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1974272 nr 4096 ram 4194304
                extent compression 0 (none)
        item 41 key (4000670 EXTENT_DATA 1982464) itemoff 1769 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1143992320 nr 4096
                extent data offset 0 nr 8192 ram 8192
                extent compression 2 (lzo)
        item 42 key (4000670 EXTENT_DATA 1990656) itemoff 1716 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 1986560 nr 4096 ram 4194304
                extent compression 0 (none)
        item 43 key (4000670 EXTENT_DATA 1994752) itemoff 1663 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1144045568 nr 4096
                extent data offset 0 nr 20480 ram 20480
                extent compression 2 (lzo)
        item 44 key (4000670 EXTENT_DATA 2015232) itemoff 1610 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 2011136 nr 4096 ram 4194304
                extent compression 0 (none)
        item 45 key (4000670 EXTENT_DATA 2019328) itemoff 1557 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1144172544 nr 4096
                extent data offset 0 nr 4096 ram 4096
                extent compression 0 (none)
        item 46 key (4000670 EXTENT_DATA 2023424) itemoff 1504 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 2019328 nr 4096 ram 4194304
                extent compression 0 (none)
        item 47 key (4000670 EXTENT_DATA 2027520) itemoff 1451 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1144614912 nr 4096
                extent data offset 0 nr 32768 ram 32768
                extent compression 2 (lzo)
        item 48 key (4000670 EXTENT_DATA 2060288) itemoff 1398 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 2056192 nr 12288 ram 4194304
                extent compression 0 (none)
        item 49 key (4000670 EXTENT_DATA 2072576) itemoff 1345 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 1144692736 nr 4096
                extent data offset 0 nr 8192 ram 8192
                extent compression 2 (lzo)
        item 50 key (4000670 EXTENT_DATA 2080768) itemoff 1292 itemsize 53
                generation 24749502 type 1 (regular)
                extent data disk byte 0 nr 0
                extent data offset 2076672 nr 4096 ram 4194304
                extent compression 0 (none)


=3D=3D=3D Block 44900352  =3D=3D=3D
btrfs ins dump-tree -b 44900352 /dev/dm-0
btrfs-progs v5.6
leaf 44900352 items 19 free space 591 generation 24749527 owner FS_TREE
leaf 44900352 flags 0x1(WRITTEN) backref revision 1
fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
        item 0 key (4000688 INODE_ITEM 0) itemoff 3835 itemsize 160
                generation 24749518 transid 24749521 size 100 nbytes 100
                block group 0 mode 100666 links 1 uid 1000 gid 1000 rdev 0
                sequence 2 flags 0x0(none)
                atime 1591262309.809076167 (2020-06-04 11:18:29)
                ctime 1591262311.864927044 (2020-06-04 11:18:31)
                mtime 1591262309.809076167 (2020-06-04 11:18:29)
                otime 1591262309.809076167 (2020-06-04 11:18:29)
        item 1 key (4000688 INODE_REF 134426) itemoff 3813 itemsize 22
                index 6104 namelen 12 name: profile_stor
        item 2 key (4000688 EXTENT_DATA 0) itemoff 3749 itemsize 64
                generation 24749518 type 0 (inline)
                inline extent data size 43 ram_bytes 100 compression 2 (lzo=
)
        item 3 key (4000691 INODE_ITEM 0) itemoff 3589 itemsize 160
                generation 24749521 transid 24749525 size 2428 nbytes 2428
                block group 0 mode 100666 links 1 uid 1000 gid 1000 rdev 0
                sequence 2 flags 0x0(none)
                atime 1591262311.868926754 (2020-06-04 11:18:31)
                ctime 1591262316.124617986 (2020-06-04 11:18:36)
                mtime 1591262311.872926463 (2020-06-04 11:18:31)
                otime 1591262311.868926754 (2020-06-04 11:18:31)
        item 4 key (4000691 INODE_REF 134426) itemoff 3562 itemsize 27
                index 6107 namelen 17 name: notification_buck
        item 5 key (4000691 EXTENT_DATA 0) itemoff 2294 itemsize 1268
                generation 24749521 type 0 (inline)
                inline extent data size 1247 ram_bytes 2428 compression 2 (=
lzo)
        item 6 key (4000692 INODE_ITEM 0) itemoff 2134 itemsize 160
                generation 24749521 transid 24749525 size 100 nbytes 100
                block group 0 mode 100666 links 1 uid 1000 gid 1000 rdev 0
                sequence 2 flags 0x0(none)
                atime 1591262311.868926754 (2020-06-04 11:18:31)
                ctime 1591262316.124617986 (2020-06-04 11:18:36)
                mtime 1591262311.868926754 (2020-06-04 11:18:31)
                otime 1591262311.868926754 (2020-06-04 11:18:31)
        item 7 key (4000692 INODE_REF 134426) itemoff 2107 itemsize 27
                index 6108 namelen 17 name: notification_stor
        item 8 key (4000692 EXTENT_DATA 0) itemoff 2043 itemsize 64
                generation 24749522 type 0 (inline)
                inline extent data size 43 ram_bytes 100 compression 2 (lzo=
)
        item 9 key (4000695 INODE_ITEM 0) itemoff 1883 itemsize 160
                generation 24749525 transid 24749525 size 1241 nbytes 1241
                block group 0 mode 100666 links 1 uid 1000 gid 1000 rdev 0
                sequence 0 flags 0x0(none)
                atime 1591262316.124617986 (2020-06-04 11:18:36)
                ctime 1591262316.128617696 (2020-06-04 11:18:36)
                mtime 1591262316.128617696 (2020-06-04 11:18:36)
                otime 1591262316.124617986 (2020-06-04 11:18:36)
        item 10 key (4000695 INODE_REF 134426) itemoff 1846 itemsize 37
                index 6109 namelen 27 name: media_children_compact_buck
        item 11 key (4000695 EXTENT_DATA 0) itemoff 1571 itemsize 275
                generation 24749525 type 0 (inline)
                inline extent data size 254 ram_bytes 1241 compression 2 (l=
zo)
        item 12 key (4000696 INODE_ITEM 0) itemoff 1411 itemsize 160
                generation 24749525 transid 24749527 size 100 nbytes 100
                block group 0 mode 100666 links 1 uid 1000 gid 1000 rdev 0
                sequence 0 flags 0x0(none)
                atime 1591262316.128617696 (2020-06-04 11:18:36)
                ctime 1591262316.128617696 (2020-06-04 11:18:36)
                mtime 1591262316.128617696 (2020-06-04 11:18:36)
                otime 1591262316.128617696 (2020-06-04 11:18:36)
        item 13 key (4000696 INODE_REF 134426) itemoff 1374 itemsize 37
                index 6110 namelen 27 name: media_children_compact_stor
        item 14 key (4000696 EXTENT_DATA 0) itemoff 1310 itemsize 64
                generation 24749527 type 0 (inline)
                inline extent data size 43 ram_bytes 100 compression 2 (lzo=
)
        item 15 key (4000697 INODE_ITEM 0) itemoff 1150 itemsize 160
                generation 24749526 transid 24749526 size 8720 nbytes 12288
                block group 0 mode 100644 links 1 uid 1002 gid 1002 rdev 0
                sequence 0 flags 0x0(none)
                atime 1591262316.772570966 (2020-06-04 11:18:36)
                ctime 1591262316.772570966 (2020-06-04 11:18:36)
                mtime 1591262316.772570966 (2020-06-04 11:18:36)
                otime 1591262316.772570966 (2020-06-04 11:18:36)
        item 16 key (4000697 INODE_REF 3137452) itemoff 1119 itemsize 31
                index 44 namelen 21 name: Textures13.db-journal
        item 17 key (4000697 EXTENT_DATA 0) itemoff 1066 itemsize 53
                generation 24749526 type 1 (regular)
                extent data disk byte 14946304 nr 4096
                extent data offset 0 nr 12288 ram 12288
                extent compression 2 (lzo)
        item 18 key (ORPHAN ORPHAN_ITEM 4000554) itemoff 1066 itemsize 0
                orphan item


=3D=3D=3D Block 55352561664 =3D=3D=3D
$ btrfs ins dump-tree -b 55352561664 /dev/dm-0
btrfs-progs v5.6
leaf 55352561664 items 33 free space 1095 generation 24749497 owner ROOT_TR=
EE
leaf 55352561664 flags 0x1(WRITTEN) backref revision 1
fs uuid 65005d0f-f8ea-4f77-8372-eb8b53198685
chunk uuid 137764f6-c8e6-45b3-b275-82d8558c1ff9
        item 0 key (289 INODE_ITEM 0) itemoff 3835 itemsize 160
                generation 24703953 transid 24703953 size 262144
nbytes 8595701760
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 32790 flags
0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1970-01-01 01:00:00)
                ctime 1589235096.486856306 (2020-05-12 00:11:36)
                mtime 0.0 (1970-01-01 01:00:00)
                otime 0.0 (1970-01-01 01:00:00)
        item 1 key (289 EXTENT_DATA 0) itemoff 3782 itemsize 53
                generation 24703953 type 1 (regular)
                extent data disk byte 3544403968 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 2 key (290 INODE_ITEM 0) itemoff 3622 itemsize 160
                generation 20083477 transid 20083477 size 262144
nbytes 6823346176
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 26029 flags
0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1970-01-01 01:00:00)
                ctime 1587576718.255911112 (2020-04-22 19:31:58)
                mtime 0.0 (1970-01-01 01:00:00)
                otime 0.0 (1970-01-01 01:00:00)
        item 3 key (290 EXTENT_DATA 0) itemoff 3569 itemsize 53
                generation 20083477 type 1 (regular)
                extent data disk byte 3373088768 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 4 key (291 INODE_ITEM 0) itemoff 3409 itemsize 160
                generation 24712508 transid 24712508 size 262144
nbytes 5454692352
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 20808 flags
0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1970-01-01 01:00:00)
                ctime 1589569287.32299836 (2020-05-15 21:01:27)
                mtime 0.0 (1970-01-01 01:00:00)
                otime 0.0 (1970-01-01 01:00:00)
        item 5 key (291 EXTENT_DATA 0) itemoff 3356 itemsize 53
                generation 24712508 type 1 (regular)
                extent data disk byte 5286600704 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 6 key (292 INODE_ITEM 0) itemoff 3196 itemsize 160
                generation 24749497 transid 24749497 size 262144
nbytes 3022001274880
                block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
                sequence 11528020 flags
0x1b(NODATASUM|NODATACOW|NOCOMPRESS|PREALLOC)
                atime 0.0 (1970-01-01 01:00:00)
                ctime 1591262206.30950961 (2020-06-04 11:16:46)
                mtime 0.0 (1970-01-01 01:00:00)
                otime 0.0 (1970-01-01 01:00:00)
        item 7 key (292 EXTENT_DATA 0) itemoff 3143 itemsize 53
                generation 24749497 type 1 (regular)
                extent data disk byte 2998218752 nr 262144
                extent data offset 0 nr 262144 ram 262144
                extent compression 0 (none)
        item 8 key (FREE_SPACE UNTYPED 29360128) itemoff 3102 itemsize 41
                location key (256 INODE_ITEM 0)
                cache generation 24749495 entries 18 bitmaps 8
        item 9 key (FREE_SPACE UNTYPED 1103101952) itemoff 3061 itemsize 41
                location key (257 INODE_ITEM 0)
                cache generation 24749496 entries 34 bitmaps 8
        item 10 key (FREE_SPACE UNTYPED 2176843776) itemoff 3020 itemsize 4=
1
                location key (258 INODE_ITEM 0)
                cache generation 24749497 entries 11 bitmaps 8
        item 11 key (FREE_SPACE UNTYPED 3250585600) itemoff 2979 itemsize 4=
1
                location key (259 INODE_ITEM 0)
                cache generation 24749497 entries 8 bitmaps 8
        item 12 key (FREE_SPACE UNTYPED 4324327424) itemoff 2938 itemsize 4=
1
                location key (261 INODE_ITEM 0)
                cache generation 24749495 entries 141 bitmaps 8
        item 13 key (FREE_SPACE UNTYPED 5398069248) itemoff 2897 itemsize 4=
1
                location key (260 INODE_ITEM 0)
                cache generation 24749493 entries 23 bitmaps 8
        item 14 key (FREE_SPACE UNTYPED 6471811072) itemoff 2856 itemsize 4=
1
                location key (262 INODE_ITEM 0)
                cache generation 24749493 entries 70 bitmaps 8
        item 15 key (FREE_SPACE UNTYPED 7545552896) itemoff 2815 itemsize 4=
1
                location key (263 INODE_ITEM 0)
                cache generation 24749493 entries 22 bitmaps 8
        item 16 key (FREE_SPACE UNTYPED 8619294720) itemoff 2774 itemsize 4=
1
                location key (264 INODE_ITEM 0)
                cache generation 24729885 entries 35 bitmaps 8
        item 17 key (FREE_SPACE UNTYPED 9693036544) itemoff 2733 itemsize 4=
1
                location key (265 INODE_ITEM 0)
                cache generation 22144003 entries 30 bitmaps 8
        item 18 key (FREE_SPACE UNTYPED 10766778368) itemoff 2692 itemsize =
41
                location key (266 INODE_ITEM 0)
                cache generation 24749177 entries 148 bitmaps 4
        item 19 key (FREE_SPACE UNTYPED 11840520192) itemoff 2651 itemsize =
41
                location key (267 INODE_ITEM 0)
                cache generation 24749152 entries 33 bitmaps 8
        item 20 key (FREE_SPACE UNTYPED 12914262016) itemoff 2610 itemsize =
41
                location key (268 INODE_ITEM 0)
                cache generation 24706177 entries 11 bitmaps 8
        item 21 key (FREE_SPACE UNTYPED 13988003840) itemoff 2569 itemsize =
41
                location key (269 INODE_ITEM 0)
                cache generation 21296150 entries 46 bitmaps 8
        item 22 key (FREE_SPACE UNTYPED 15061745664) itemoff 2528 itemsize =
41
                location key (270 INODE_ITEM 0)
                cache generation 24729843 entries 58 bitmaps 8
        item 23 key (FREE_SPACE UNTYPED 16135487488) itemoff 2487 itemsize =
41
                location key (271 INODE_ITEM 0)
                cache generation 20064465 entries 36 bitmaps 8
        item 24 key (FREE_SPACE UNTYPED 17209229312) itemoff 2446 itemsize =
41
                location key (272 INODE_ITEM 0)
                cache generation 20079294 entries 86 bitmaps 0
        item 25 key (FREE_SPACE UNTYPED 18282971136) itemoff 2405 itemsize =
41
                location key (273 INODE_ITEM 0)
                cache generation 20081218 entries 38 bitmaps 8
        item 26 key (FREE_SPACE UNTYPED 19356712960) itemoff 2364 itemsize =
41
                location key (274 INODE_ITEM 0)
                cache generation 20088898 entries 22 bitmaps 4
        item 27 key (FREE_SPACE UNTYPED 20430454784) itemoff 2323 itemsize =
41
                location key (275 INODE_ITEM 0)
                cache generation 20055389 entries 91 bitmaps 7
        item 28 key (FREE_SPACE UNTYPED 35462840320) itemoff 2282 itemsize =
41
                location key (289 INODE_ITEM 0)
                cache generation 24703953 entries 10 bitmaps 8
        item 29 key (FREE_SPACE UNTYPED 44052774912) itemoff 2241 itemsize =
41
                location key (290 INODE_ITEM 0)
                cache generation 20083477 entries 36 bitmaps 8
        item 30 key (FREE_SPACE UNTYPED 52642709504) itemoff 2200 itemsize =
41
                location key (291 INODE_ITEM 0)
                cache generation 24712508 entries 9 bitmaps 8
        item 31 key (FREE_SPACE UNTYPED 54857302016) itemoff 2159 itemsize =
41
                location key (292 INODE_ITEM 0)
                cache generation 24749497 entries 24 bitmaps 8
        item 32 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1920 itemsize 239
                generation 4 root_dirid 256 bytenr 29380608 level 0 refs 1
                lastsnap 0 byte_limit 0 bytes_used 4096 flags 0x0(none)
                drop key (0 UNKNOWN.0 0) level 0
--- snap ---



On Thu, Jun 4, 2020 at 3:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/6/3 =E4=B8=8B=E5=8D=889:37, Thorsten Rehm wrote:
> > Hi,
> >
> > I've updated my system (Debian testing) [1] several months ago (~
> > December) and I noticed a lot of corrupt leaf messages flooding my
> > kern.log [2]. Furthermore my system had some trouble, e.g.
> > applications were terminated after some uptime, due to the btrfs
> > filesystem errors. This was with kernel 5.3.
> > The last time I tried was with Kernel 5.6.0-1-amd64 and the problem per=
sists.
> >
> > I've downgraded my kernel to 4.19.0-8-amd64 from the Debian Stable
> > release and with this kernel there aren't any corrupt leaf messages
> > and the problem is gone. IMHO, it must be something coming with kernel
> > 5.3 (or 5.x).
>
> V5.3 introduced a lot of enhanced metadata sanity checks, and they catch
> such *obviously* wrong metadata.
> >
> > My harddisk is a SSD which is responsible for the root partition. I've
> > encrypted my filesystem with LUKS and just right after I entered my
> > password at the boot, the first corrupt leaf errors appear.
> >
> > An error message looks like this:
> > May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid root =
item
> > size, have 239 expect 439
>
> Btrfs root items have fixed size. This is already something very bad.
>
> Furthermore, the item size is smaller than expected, which means we can
> easily get garbage. I'm a little surprised that older kernel can even
> work without crashing the whole kernel.
>
> Some extra info could help us to find out how badly the fs is corrupted.
> # btrfs ins dump-tree -b 35799040 /dev/dm-0
>
> >
> > "root=3D1", "slot=3D32", "have 239 expect 439" is always the same at ev=
ery
> > error line. Only the block number changes.
>
> And dumps for the other block numbers too.
>
> >
> > Interestingly it's the very same as reported to the ML here [3]. I've
> > contacted the reporter, but he didn't have a solution for me, because
> > he changed to a different filesystem.
> >
> > I've already tried "btrfs scrub" and "btrfs check --readonly /" in
> > rescue mode, but w/o any errors. I've also checked the S.M.A.R.T.
> > values of the SSD, which are fine. Furthermore I've tested my RAM, but
> > again, w/o any errors.
>
> This doesn't look like a bit flip, so not RAM problems.
>
> Don't have any better advice until we got the dumps, but I'd recommend
> to backup your data since it's still possible.
>
> Thanks,
> Qu
>
> >
> > So, I have no more ideas what I can do. Could you please help me to
> > investigate this further? Could it be a bug?
> >
> > Thank you very much.
> >
> > Best regards,
> > Thorsten
> >
> >
> >
> > 1:
> > $ cat /etc/debian_version
> > bullseye/sid
> >
> > $ uname -a
> > [no problem with this kernel]
> > Linux foo 4.19.0-8-amd64 #1 SMP Debian 4.19.98-1 (2020-01-26) x86_64 GN=
U/Linux
> >
> > $ btrfs --version
> > btrfs-progs v5.6
> >
> > $ sudo btrfs fi show
> > Label: 'slash'  uuid: 65005d0f-f8ea-4f77-8372-eb8b53198685
> >         Total devices 1 FS bytes used 7.33GiB
> >         devid    1 size 115.23GiB used 26.08GiB path /dev/mapper/sda5_c=
rypt
> >
> > $ btrfs fi df /
> > Data, single: total=3D22.01GiB, used=3D7.16GiB
> > System, DUP: total=3D32.00MiB, used=3D4.00KiB
> > System, single: total=3D4.00MiB, used=3D0.00B
> > Metadata, DUP: total=3D2.00GiB, used=3D168.19MiB
> > Metadata, single: total=3D8.00MiB, used=3D0.00B
> > GlobalReserve, single: total=3D25.42MiB, used=3D0.00B
> >
> >
> > 2:
> > [several messages per second]
> > May  7 14:39:34 foo kernel: [  100.162145] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D35799040 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:35 foo kernel: [  100.998530] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D35885056 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:35 foo kernel: [  101.348650] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D35926016 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:36 foo kernel: [  101.619437] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D35995648 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:36 foo kernel: [  101.874069] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D36184064 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:36 foo kernel: [  102.339087] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D36319232 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:37 foo kernel: [  102.629429] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D36380672 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:37 foo kernel: [  102.839669] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D36487168 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:37 foo kernel: [  103.109183] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D36597760 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> > May  7 14:39:37 foo kernel: [  103.299101] BTRFS critical (device
> > dm-0): corrupt leaf: root=3D1 block=3D36626432 slot=3D32, invalid root =
item
> > size, have 239 expect 439
> >
> > 3:
> > https://lore.kernel.org/linux-btrfs/19acbd39-475f-bd72-e280-5f6c6496035=
c@web.de/
> >
>
