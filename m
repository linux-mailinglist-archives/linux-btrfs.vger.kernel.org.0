Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1515023F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 07:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbiDOFhL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 01:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiDOFhH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 01:37:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB1565497
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650000862;
        bh=f/SsYMUl57WDoEc69rJqF6YKeo1z8+iFtJq7uHypdmQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AoxoPGiLycJa2m/JfY0wWnO7/EBl4wOOChY9XvZTNox+bdHyox58Atm7Xr/E/VAW4
         GYEgCTPcbDswaGeUlJgWak8qbaFPf8LcMT+2CANSnRCDCY+EDpEV3wEgj0YQeRj0sY
         tQM7g2ZmaP1Sr+FK0uoG5VyS75oas1xOUcGH/7Bw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvmO-1oGDm745yA-00b2yS; Fri, 15
 Apr 2022 07:34:22 +0200
Message-ID: <c7b952c0-6c86-1e72-5221-4876047cccbd@gmx.com>
Date:   Fri, 15 Apr 2022 13:34:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 04/17] btrfs: introduce new cached members for
 btrfs_raid_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <38fdde8665c4765551fea3c5818bfa79b1214fa6.1649753690.git.wqu@suse.com>
 <YlkDN0OaSUTKGeRr@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YlkDN0OaSUTKGeRr@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7TA04eOtKVw4QkSCbPpjbIA0BL74hvk0lUbgcziU3Jnqo8V622i
 RVh3/mZH1rwcH6Dt7fmmDu8o/dlj94LYvQB4a+PGnV8b4sT9O3CkAgqzzrcAqKfpy3vDBby
 gKFCxqaXzJ5fjGHITk3HAnFeoZ1xvv7bFVLGB5hhuFxhaomdlPuve4cv6F99TUf/Jq+iRsB
 o5gjjtQc9XFokvOeyePmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jq0k4u6Vs1U=:WlfSx8oHIESAZD90UXVmyN
 nXE2vr1SAG/e6+1O0U59ZwIR/n/KMogXMlcZtx+uuXFgGjwcP4vXrnYNC1ElYRDf79a6Mzaca
 Byy2vsoXfbgqyf8gMhcgxGqH62NE19Zh/ij2o+aGAHtG51D2/fsyG0AJlp825V1QYKhmG7Dzt
 TgBG8zx6zgTwIcelMPSpq2sWbQS/qTB6DDNq0iPN+eRhg/lqeicaXIIBCJnl0/Xwgvo6QCnJ1
 uJua3dct/x8ZqSTPO7IMYSERs3MWY7Xuw7omnknjDkEHMCui9LKrSqtGLfADsQ6SyoTCbwMlg
 9fsAyexG5UxqfyabEngGVlv+AsXR1deeAcuvf0GoRnlxXfmtBbBQsEFrZzzjFbuBeoFdJj4hR
 N6CiMhbpuKVqO8G36GTualy8qfl4OhD35jzzZ+T0+jQz9Tx9fzLhisjmkJWY8+3u9wAIXjjqd
 RpD/KyyL7bhG732Vm7vL9Wb0UozK/gPC/dCQlfJP72xjhDZBNRjzSqPvYXZuIvpgvYyEj6tMq
 PQyBIR7VzCJ7XDjZBOmxLkDcghspOKufd1yAEBSDR/Q5PApIj9VTCF0O6Qq7UaE5LinIP0Vu/
 WMLsU7ulfrZnHNFbzZlyZ8lR5YyDnOsNIGex89lbH9N2hGBZxZPowOCwDF8cQTsq/fUWfQdMQ
 4kx1H6Yhi6TE1rU3PmK3nBtM9/s9xt8XE1de6k5q6uJGPq4xUaGqWHQzo7khKFjhrHANiYxPF
 qdFfOL+9qmtasmvTSAXqaNiABykaHiVD1y/PegTTNZLQj5QdtqTMtRMz+MT2PI+UzBQRIJZQo
 9O3AWz4fvRq6PQzbqDm0dB/0XGOd7ljgr6vW4u98I+Osiiz1/lpRzv5yjCL3hJcdEFx4aqiOL
 eFvICvnHdEQY3fyDd818NY4CFVVxQPETa8KCoFZFAdc9c42GPG9tWar+0axEzI5k69yImsj6Y
 2uRAJECGF9oECAeayl1xj2OFyzIPGf+/o1tVMK2pvoLsQAmhjB2zu11ATxrZ/dS5xH93HSk14
 crbpRcttCPrbXo4PiMqbdB21MFDLTEnmNgac1lpfmgjt7hSTzDd8WcqgAgfFlDo8FqfX7Sabp
 jf3tZgTeumAg8Y=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/15 13:31, Christoph Hellwig wrote:
> What is cached about these members?

It's just like btrfs_fs_info::sectorsize, gives us a quick way to use,
without calculating the same value again and again.

BTW, are you suggesting to calculate everything when needed?

I'm fine either way.

Thanks,
Qu
