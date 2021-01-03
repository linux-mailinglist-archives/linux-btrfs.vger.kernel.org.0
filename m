Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17B2E8A0E
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbhACCxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Jan 2021 21:53:45 -0500
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:56837 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbhACCxp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Jan 2021 21:53:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04727131|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00659476-0.000735838-0.992669;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JEjAmCU_1609642381;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JEjAmCU_1609642381)
          by smtp.aliyun-inc.com(10.147.42.198);
          Sun, 03 Jan 2021 10:53:02 +0800
Date:   Sun, 03 Jan 2021 10:53:02 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     shngmao@gmail.com
Subject: Re: [PATCH] btrfs-progs: align btrfs receive buffer to enable fast CRC
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20201226214606.49241-1-shngmao@gmail.com>
References: <20201226214606.49241-1-shngmao@gmail.com>
Message-Id: <20210103105301.523C.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Sheng

> From: Sheng Mao <shngmao@gmail.com>
> 
> To use optimized CRC implemention, the input buffer must be
> unsigned long aligned. btrfs receive calculates checksum based on
> read_buf, including btrfs_cmd_header (with zero-ed CRC field)
> and command content. GCC attribute is added to both struct
> btrfs_send_stream and read_buf to make sure read_buf is allocated
> with proper alignment.
> 
> Issue: #324
> Signed-off-by: Sheng Mao <shngmao@gmail.com>
> ---
>  common/send-stream.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/common/send-stream.c b/common/send-stream.c
> index 69d75168..b13aa16e 100644
> --- a/common/send-stream.c
> +++ b/common/send-stream.c
> @@ -26,7 +26,8 @@
>  
>  struct btrfs_send_stream {
>  	int fd;
> -	char read_buf[BTRFS_SEND_BUF_SIZE];
> +	char read_buf[BTRFS_SEND_BUF_SIZE]
> +		__attribute__((aligned(sizeof(unsigned long))));
>  
>  	int cmd;

Can we move 'int cmd' to before 'char read_buf' too?

There is a hole between 'int fd' and 'char read_buf' after the
addiatioin of '__attribute__((aligned(sizeof(unsigned long))))'
in x86_64.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/01/03

>  	struct btrfs_cmd_header *cmd_hdr;
> @@ -41,7 +42,7 @@ struct btrfs_send_stream {
>  
>  	struct btrfs_send_ops *ops;
>  	void *user;
> -};
> +} __attribute__((aligned(sizeof(unsigned long))));
>  
>  /*
>   * Read len bytes to buf.
> -- 
> 2.29.2


