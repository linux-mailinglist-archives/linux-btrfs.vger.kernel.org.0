Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54F43732B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 01:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhEDXZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 19:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhEDXZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 19:25:25 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A5BC06174A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 May 2021 16:24:29 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t7so2787249qtn.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 May 2021 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fBU4z1MPL7r2I9p/wYezV4xkdg3Og81NuNGZfa/2Wkw=;
        b=nAOMAa2FPGp4Mr9uWQ7pF5G/34fdOc93Siz71/+Rf3qlYQo3chQ0bz5vGMFJAMak+x
         89lmgCEf3/9ZDgfM+s0fR3O/bklD70pQhoESE/fkkUsrMeNJVTkSzOx64lOMfbH9Nz3f
         +eRkaAGzTnvKJrBRNR3D1EX3NKPmMbdlYrrUWIurVlZRLaSPDAX9cthpp2KppoanbNb4
         zF0ADJLTSxf8w00aqDgghJ+K1e0hhnkjglGWDCcdACtzZLIWlGV7RWltHerz/p6eYQSH
         hlTZwYXIczYTZhKKhs5GmSXgBN1jn6Kd2ZZh06+8IAXaM8ZX6mYYPqQRWw1+RTlPsrnS
         cvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fBU4z1MPL7r2I9p/wYezV4xkdg3Og81NuNGZfa/2Wkw=;
        b=D9Nm2j2ojMsfj3fZ4lFO/Z8k3Gfd4oZd0qkqjwyXip/RTxxn7Xc2VUtVKfDw2CzT7v
         PW3XUS6ktmCMMhMbcB1FNPqscStsGEKY72bWtaTozWR4+mw0QJaX5vieAe3Tb5HOmpx9
         x/jGeOQfHX7rbjNjj8jo48j0V9wNQcV4OuKGwEnFZIuqa4JeMCeEkWEIJpiGkVZc3heh
         8dmlhfHyIMioG4FDlFO8x/8DgydNX1kAfo38QCIKwoR4teDJMiSJnayLhYHhGeoNz12T
         NBJNLZ6rOiK0veo4kY7OEiRLNGSxNuTPncQMtX20nvEAGK8oMwipbyLcAlgeHd1+I4wu
         Upqw==
X-Gm-Message-State: AOAM531JT/5YeetOW/dV6iIIXCWFqH+xItIKv8CuSyZgZSUtBQNAOqr0
        xWVkVraqFZujR68YuoCNcVE=
X-Google-Smtp-Source: ABdhPJyff7SRjCZ94pxA1dJud+vCiJzh3mivfF6CvLmOC8qeqkfMTAhBvKHV3YmYkl1Lu0hAtISarA==
X-Received: by 2002:a05:622a:1754:: with SMTP id l20mr13426349qtk.120.1620170668413;
        Tue, 04 May 2021 16:24:28 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id n18sm3618614qtv.70.2021.05.04.16.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 16:24:27 -0700 (PDT)
Subject: Re: [PATCH 00/49] image: Reduce #ifdefs and ad-hoc defines in image
 code
To:     Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andre Przywara <andre.przywara@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adam Ford <aford173@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrii Anisov <andrii_anisov@epam.com>,
        Asherah Connor <ashe@kivikakk.ee>,
        Bastian Krause <bst@pengutronix.de>,
        "Chan, Donald" <hoiho@lab126.com>,
        Chee Hong Ang <chee.hong.ang@intel.com>,
        Chin-Liang See <chin.liang.see@intel.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Dinh Nguyen <dinh.nguyen@intel.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Fabien Parent <fparent@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis@collabora.com>,
        George McCollister <george.mccollister@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Hongwei Zhang <hongweiz@ami.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Joel Stanley <joel@jms.id.au>, Jonathan Gray <jsg@jsg.id.au>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Kever Yang <kever.yang@rock-chips.com>,
        Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Lukasz Majewski <lukma@denx.de>,
        Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>,
        Marek Behun <marek.behun@nic.cz>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Ovidiu Panait <ovidiu.panait@windriver.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Patrick Oppenlander <patrick.oppenlander@gmail.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Qu Wenruo <wqu@suse.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Reuben Dowle <reubendowle0@gmail.com>,
        Rick Chen <rick@andestech.com>,
        Samuel Holland <samuel@sholland.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Siew Chin Lim <elly.siew.chin.lim@intel.com>,
        Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        T Karthik Reddy <t.karthik.reddy@xilinx.com>,
        Tero Kristo <t-kristo@ti.com>,
        Thirupathaiah Annapureddy <thiruan@linux.microsoft.com>,
        Trevor Woerner <twoerner@gmail.com>,
        Wasim Khan <wasim.khan@nxp.com>, chenshuo <chenshuo@eswin.com>,
        linux-btrfs@vger.kernel.org, uboot-snps-arc@synopsys.com
References: <20210503231136.744283-1-sjg@chromium.org>
 <20210504214016.GA17669@bill-the-cat>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <fee751a1-180b-6b31-3594-586f11549069@gmail.com>
Date:   Tue, 4 May 2021 19:24:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210504214016.GA17669@bill-the-cat>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Tom,

On 5/4/21 5:40 PM, Tom Rini wrote:
> On Mon, May 03, 2021 at 05:10:47PM -0600, Simon Glass wrote:
> 
>> Much of the image-handling code predates the introduction of Kconfig and
>> has quite a few #ifdefs in it. It also uses its own IMAGE_... defines to
>> help reduce the #ifdefs, which is unnecessary now that we can use
>> IS_ENABLED() et al.
>>
>> The image code is also where quite a bit of code is shared with the host
>> tools. At present this uses a lot of checks of USE_HOSTCC.
>>
>> This series introduces 'host' Kconfig options and a way to use
>> CONFIG_IS_ENABLED() to check them. This works in a similar way to SPL, so
>>
>>     CONFIG_IS_ENABLED(FIT)
>>
>> will evaluate to true on the host build (USE_HOSTCC) if CONFIG_HOST_FIT is
>> enabled. This allows quite a bit of clean-up of the image.h header file
>> and many of the image C files.
>>
>> The 'host' Kconfig options should help to solve a more general problem in
>> that we mostly want the host tools to build with all features enabled, no
>> matter which features the 'target' build actually uses. This is a pain to
>> arrange at present, but with 'host' Kconfigs, we can just define them all
>> to y.
>>
>> There are cases where the host tools do not have features which are
>> present on the target, for example environment and physical addressing.
>> To help with this, some of the core image code is split out into
>> image-board.c and image-host.c files.
>>
>> Even with these changes, some #ifdefs remain (101 down to 42 in
>> common/image*). But the code is somewhat easier to follow and there are
>> fewer build paths.
>>
>> In service of the above, this series includes a patch to add an API function
>> for zstd, so the code can be dropped from bootm.c
>>
>> It also introduces a function to handle manual relocation.
> 
> I like this idea overall.  The good news is this reduces the size in a
> few places.  The bad news, but I can live with if we can't restructure
> the changes more, is a few functions grow a bit.  This shows the good
> and the bad (something like sama5d2_ptc_ek_mmc shows only growth, to be
> clear):
What tool do you use to generate this output? Thanks.

--Sean

>              px30-core-edimm2.2-px30: all -36 rodata -24 text -12
>                 u-boot: add: 0/0, grow: 3/-4 bytes: 36/-48 (-12)
>                   function                                   old     new   delta
>                   boot_get_fdt                               896     924     +28
>                   image_decomp                               372     376      +4
>                   boot_get_ramdisk                           868     872      +4
>                   do_bootm_vxworks                           552     540     -12
>                   do_bootm_rtems                             124     112     -12
>                   do_bootm_plan9                             228     216     -12
>                   do_bootm_netbsd                            324     312     -12
>              odroid-c2      : all -105 bss +128 rodata -65 text -168
>                 u-boot: add: 0/0, grow: 2/-3 bytes: 108/-172 (-64)
>                   function                                   old     new   delta
>                   images                                     504     608    +104
>                   image_decomp                               372     376      +4
>                   image_setup_linux                          108      96     -12
>                   boot_get_ramdisk                           620     580     -40
>                   boot_get_fdt                               660     540    -120
>              origen         : all +47 bss +96 rodata -57 text +8
>                 u-boot: add: 0/0, grow: 15/-2 bytes: 180/-104 (76)
>                   function                                   old     new   delta
>                   images                                     288     340     +52
>                   do_bootm_states                           1304    1348     +44
>                   do_bootz                                   164     176     +12
>                   do_bootm_vxworks                           332     344     +12
>                   image_setup_libfdt                         168     176      +8
>                   image_decomp                               156     164      +8
>                   bootm_find_images                          212     220      +8
>                   boot_prep_linux                            276     284      +8
>                   image_setup_linux                           54      58      +4
>                   do_bootm_standalone                         60      64      +4
>                   do_bootm_plan9                             104     108      +4
>                   do_bootm_netbsd                            168     172      +4
>                   boot_prep_vxworks                           48      52      +4
>                   boot_jump_vxworks                            6      10      +4
>                   boot_jump_linux                            148     152      +4
>                   boot_get_ramdisk                           420     392     -28
>                   boot_get_fdt                               420     344     -76
> 
> And looking at ls1088ardb_sdcard_qspi_SECURE_BOOT I think there might be
> something wrong as that looks to drop all crypto algos from SPL.  Other
> layerscape SECURE_BOOT configs show this as well.  It does however seem
> to clear up some other issues around unused code, so a deeper dive on
> which patch is dropping stuff is needed.  I see a huge drop on
> am65x_evm_a53 / j721e_evm_a72 SPL as well but I can test those and at
> least the basic case is fine.  socfpga_agilex_atf is one I don't know
> about being right or wrong.  socfpga_agilex_vab dropping hashing code
> does look worrying however, but maybe it's a configuration issue in the
> end?
> 

