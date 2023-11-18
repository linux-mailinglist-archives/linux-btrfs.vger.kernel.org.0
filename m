Return-Path: <linux-btrfs+bounces-175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36707EFE5B
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 08:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F7D1F23479
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Nov 2023 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006CFEAD5;
	Sat, 18 Nov 2023 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOp88am3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24F1D5C
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 23:51:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507962561adso4013089e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Nov 2023 23:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700293866; x=1700898666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gHgHBNs2OiE4NXspQ1QUFdjIeAygIXUDxmpMQbTjZ24=;
        b=oOp88am39kejmliz35vAjbn7XyrWtfPvk4HJQrSw7geg8noMEv4iM1v/Kg4xlqaAfQ
         vZ6j+zKOaDCWreAYuX1XgYsxTHbhr+ld2bt1BqtT/xC7LNnWe9GKNPs11QV7mOwOfMrF
         Na1lli+ELugn2VKpQW7cW5vQaW5rSU+DkGG9bfhn0CcLil7fpglNkhNdTfgL9cY+Nnyl
         QCoqDlGAXKVlimYoHh6ntpL73vk/lENceTpszdOG2MCBhOkZIMOwUb0wzRGvK5CnYapi
         NiazMeVGQDlC0X3pYG7zo31UQ0XrlV/gUx/D74JT0rS7cRCE+sJ+eBuxhzHMKCI/w0JP
         IE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700293866; x=1700898666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHgHBNs2OiE4NXspQ1QUFdjIeAygIXUDxmpMQbTjZ24=;
        b=gaOWvBoBV3xrzXbutO5EFv+MlS2iEfXi0dFYhDon9CSWGUhfIh1VhLpfuS5fuv5p/N
         Bjnqc4MmPhaQGfIWbBG0TVzSm1NN4HvN43vI1vtJzQ/eafSXewSOnzcq/6nA5xL1m3EO
         R8saXkQvjnn2LdsUfPXyX1XjOof00uViu07+fynGDkHrUzO4iClp8Xl+3KWAz81jVt3t
         1KfcNZW33aigVtCOUnGyiJgwcgWGZ6rtkLCcqjOyZJ9l0mpsDJPxjlSpLi0SOEK9CpE4
         V5zPdQlw1ib+QmGjhSlC8gzo8suifkT1aNHFX2rLjuuajp88HrSV29iFe5nJwy4xW5pA
         Q/uA==
X-Gm-Message-State: AOJu0YwJVMLAT1u2HFnvlCfc7C6jyZDoZt0J0p1721iHyZxHGyGVOhDo
	5kVFCx1wocvrRExLfygu58oaObioehzNKVtGQtV46Q==
X-Google-Smtp-Source: AGHT+IGQ7zohXQeRPiXNWvIQOIxsfiMuCnYteLUtcoxPvF2AldOYuV/UmnpjneupWSNyuQvNoy9ZK8X83mE6YPjRnqU=
X-Received: by 2002:a19:c517:0:b0:508:1470:6168 with SMTP id
 w23-20020a19c517000000b0050814706168mr1285400lfe.57.1700293866122; Fri, 17
 Nov 2023 23:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116041043.362055-1-sjg@chromium.org> <20231116041043.362055-5-sjg@chromium.org>
In-Reply-To: <20231116041043.362055-5-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Nov 2023 09:50:30 +0200
Message-ID: <CAC_iWjLFgd0+a0NX_uxA+CNGv0f4Vb75JY3x3JvJxMHdRaohvA@mail.gmail.com>
Subject: Re: [PATCH v2 04/32] treewide: Tidy up semicolon after command macros
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Tom Rini <trini@konsulko.com>, Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>, 
	Evgeny Bachinin <EABachinin@sberdevices.ru>, Fabio Estevam <festevam@gmail.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, Michal Simek <michal.simek@amd.com>, 
	"NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Qu Wenruo <wqu@suse.com>, Stefano Babic <sbabic@denx.de>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Nov 2023 at 06:11, Simon Glass <sjg@chromium.org> wrote:
>
> The U_BOOT_CMD_COMPLETE() macro has a semicolon at the end, perhaps
> inadvertently. Some code has taken advantage of this.
>
> Tidy this up by dropping the semicolon from the macro and adding it to
> macro invocations as required.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> (no changes since v1)
>
>  board/freescale/common/vid.c | 2 +-
>  board/xilinx/common/fru.c    | 2 +-
>  board/xilinx/versal/cmds.c   | 2 +-
>  board/xilinx/zynqmp/cmds.c   | 2 +-
>  cmd/btrfs.c                  | 2 +-
>  cmd/eeprom.c                 | 2 +-
>  cmd/ext2.c                   | 4 ++--
>  cmd/fs.c                     | 8 ++++----
>  cmd/pinmux.c                 | 2 +-
>  cmd/qfw.c                    | 2 +-
>  include/command.h            | 2 +-
>  11 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/board/freescale/common/vid.c b/board/freescale/common/vid.c
> index 5ec3f2a76b19..fc5d400cfe18 100644
> --- a/board/freescale/common/vid.c
> +++ b/board/freescale/common/vid.c
> @@ -793,4 +793,4 @@ U_BOOT_CMD(
>         vdd_read, 1, 0, do_vdd_read,
>         "read VDD",
>         " - Read the voltage specified in mV"
> -)
> +);
> diff --git a/board/xilinx/common/fru.c b/board/xilinx/common/fru.c
> index c916c3d6b4c8..12b21317496a 100644
> --- a/board/xilinx/common/fru.c
> +++ b/board/xilinx/common/fru.c
> @@ -85,4 +85,4 @@ U_BOOT_CMD(
>         fru, 8, 1, do_fru,
>         "FRU table info",
>         fru_help_text
> -)
> +);
> diff --git a/board/xilinx/versal/cmds.c b/board/xilinx/versal/cmds.c
> index 9cc2cdcebf1c..2a74e49aedec 100644
> --- a/board/xilinx/versal/cmds.c
> +++ b/board/xilinx/versal/cmds.c
> @@ -98,4 +98,4 @@ U_BOOT_LONGHELP(versal,
>  U_BOOT_CMD(versal, 4, 1, do_versal,
>            "versal sub-system",
>            versal_help_text
> -)
> +);
> diff --git a/board/xilinx/zynqmp/cmds.c b/board/xilinx/zynqmp/cmds.c
> index f1f3eff501e1..9524688f27d9 100644
> --- a/board/xilinx/zynqmp/cmds.c
> +++ b/board/xilinx/zynqmp/cmds.c
> @@ -427,4 +427,4 @@ U_BOOT_CMD(
>         zynqmp, 9, 1, do_zynqmp,
>         "ZynqMP sub-system",
>         zynqmp_help_text
> -)
> +);
> diff --git a/cmd/btrfs.c b/cmd/btrfs.c
> index 98daea99e9ed..2843835d08b8 100644
> --- a/cmd/btrfs.c
> +++ b/cmd/btrfs.c
> @@ -24,4 +24,4 @@ U_BOOT_CMD(btrsubvol, 3, 1, do_btrsubvol,
>         "list subvolumes of a BTRFS filesystem",
>         "<interface> <dev[:part]>\n"
>         "     - List subvolumes of a BTRFS filesystem."
> -)
> +);
> diff --git a/cmd/eeprom.c b/cmd/eeprom.c
> index 0b6ca8c505fb..322765ad02a0 100644
> --- a/cmd/eeprom.c
> +++ b/cmd/eeprom.c
> @@ -435,4 +435,4 @@ U_BOOT_CMD(
>         "The values which can be provided with the -l option are:\n"
>         CONFIG_EEPROM_LAYOUT_HELP_STRING"\n"
>  #endif
> -)
> +);
> diff --git a/cmd/ext2.c b/cmd/ext2.c
> index 57a99516a6ac..a0ce0cf5796b 100644
> --- a/cmd/ext2.c
> +++ b/cmd/ext2.c
> @@ -42,7 +42,7 @@ U_BOOT_CMD(
>         "list files in a directory (default /)",
>         "<interface> <dev[:part]> [directory]\n"
>         "    - list files from 'dev' on 'interface' in a 'directory'"
> -)
> +);
>
>  U_BOOT_CMD(
>         ext2load,       6,      0,      do_ext2load,
> @@ -50,4 +50,4 @@ U_BOOT_CMD(
>         "<interface> [<dev[:part]> [addr [filename [bytes [pos]]]]]\n"
>         "    - load binary file 'filename' from 'dev' on 'interface'\n"
>         "      to address 'addr' from ext2 filesystem."
> -)
> +);
> diff --git a/cmd/fs.c b/cmd/fs.c
> index 6044f73af5b4..46cb43dcdb5b 100644
> --- a/cmd/fs.c
> +++ b/cmd/fs.c
> @@ -39,7 +39,7 @@ U_BOOT_CMD(
>         "      If 'bytes' is 0 or omitted, the file is read until the end.\n"
>         "      'pos' gives the file byte position to start reading from.\n"
>         "      If 'pos' is 0 or omitted, the file is read from the start."
> -)
> +);
>
>  static int do_save_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
>                            char *const argv[])
> @@ -56,7 +56,7 @@ U_BOOT_CMD(
>         "      'bytes' gives the size to save in bytes and is mandatory.\n"
>         "      'pos' gives the file byte position to start writing to.\n"
>         "      If 'pos' is 0 or omitted, the file is written from the start."
> -)
> +);
>
>  static int do_ls_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
>                          char *const argv[])
> @@ -70,7 +70,7 @@ U_BOOT_CMD(
>         "<interface> [<dev[:part]> [directory]]\n"
>         "    - List files in directory 'directory' of partition 'part' on\n"
>         "      device type 'interface' instance 'dev'."
> -)
> +);
>
>  static int do_ln_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
>                          char *const argv[])
> @@ -84,7 +84,7 @@ U_BOOT_CMD(
>         "<interface> <dev[:part]> target linkname\n"
>         "    - create a symbolic link to 'target' with the name 'linkname' on\n"
>         "      device type 'interface' instance 'dev'."
> -)
> +);
>
>  static int do_fstype_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
>                              char *const argv[])
> diff --git a/cmd/pinmux.c b/cmd/pinmux.c
> index f17cf4110d9f..105f01eaafff 100644
> --- a/cmd/pinmux.c
> +++ b/cmd/pinmux.c
> @@ -178,4 +178,4 @@ U_BOOT_CMD(pinmux, CONFIG_SYS_MAXARGS, 1, do_pinmux,
>            "list                     - list UCLASS_PINCTRL devices\n"
>            "pinmux dev [pincontroller-name] - select pin-controller device\n"
>            "pinmux status [-a | pin-name]   - print pin-controller muxing [for all | for pin-name]\n"
> -)
> +);
> diff --git a/cmd/qfw.c b/cmd/qfw.c
> index d6ecfa60d5a7..1b8c775ebf5a 100644
> --- a/cmd/qfw.c
> +++ b/cmd/qfw.c
> @@ -121,4 +121,4 @@ U_BOOT_CMD(
>         "    - list                             : print firmware(s) currently loaded\n"
>         "    - cpus                             : print online cpu number\n"
>         "    - load <kernel addr> <initrd addr> : load kernel and initrd (if any), and setup for zboot\n"
> -)
> +);
> diff --git a/include/command.h b/include/command.h
> index 6262365e128f..5bd3ecbe8f91 100644
> --- a/include/command.h
> +++ b/include/command.h
> @@ -390,7 +390,7 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
>  #define U_BOOT_CMD_COMPLETE(_name, _maxargs, _rep, _cmd, _usage, _help, _comp) \
>         ll_entry_declare(struct cmd_tbl, _name, cmd) =                  \
>                 U_BOOT_CMD_MKENT_COMPLETE(_name, _maxargs, _rep, _cmd,  \
> -                                               _usage, _help, _comp);
> +                                               _usage, _help, _comp)
>
>  #define U_BOOT_CMDREP_COMPLETE(_name, _maxargs, _cmd_rep, _usage,      \
>                                _help, _comp)                            \
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>

