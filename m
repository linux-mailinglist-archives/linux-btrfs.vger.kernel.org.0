Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB8370B763
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEVIQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 04:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEVIQV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 04:16:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024ADB0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 01:16:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-309550263e0so3183253f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684743378; x=1687335378;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AgQHXRqBL6sIjekEHRGeb4d9imcdcXKEJ98OIw4yTKg=;
        b=XBA9c08aavHUcbKsMbvGBuDaMjzzm1hyLnxUv/iESOzE6jn4Wiu/Yf3lO/PSv4rv1i
         WD6l0cGyMEE7VwwYTnTZ7CyU76egcTtiK/VkSdx4mFAhcQz3GPmXCQ9e2bntSmr+dIUW
         yKCwcu/h+KJ+2fF1Sj1h6k2L2l79R0RNy1pSjXu0qn/6/3CE8OPo1sqpeMX3+PUKZxaP
         7xevqo3ao58RsmEz7ZFKsZtms4LLQnFNdKImCdu53HQnOvA/EGl9l8SYI3BCTJL03fHL
         HNCI8pEa+AdY6AegGEzg8QTV8u1YdZqAeWKYL8W4RCG1osF6strkA2WjJ9OdMfkJz29Q
         Q0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684743378; x=1687335378;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgQHXRqBL6sIjekEHRGeb4d9imcdcXKEJ98OIw4yTKg=;
        b=Q1LNcxhm7Iq+vCC7qvyzM0ZyiD7XXpU4S5r/KBJXVJa/XTKZXVsk8q0UCJNIH/CX6+
         2AHNTVqUyTZ+H/tzmp/YtEsdwXyYNm+F+0/laMy9RYG3mg5QJjkJgATG7EnPRHD7gsPH
         ro+escvdqoLvPVdG6r52c7YO4VHMnH78VXwaj96RcOEL1/Qb/xs7YeSmYYh8lPUZAFct
         4OTi2dGbKQlYKM9k3J9MQTwEfIL9rnKXeSFOTf7W/cA8xQKo6DSMLqli9vn53w5ozTJ4
         T2aR5owTf7b+Y7zO98NzC1oPSVV0s32R725WkokcrE1HG6BhFXUyn5XCAGwEp15LzT27
         BN3w==
X-Gm-Message-State: AC+VfDwdolYgkgTaymhVAs4Dcd+KkkmH/g5CBWnZEt7m2N5L4DaAm5uV
        /xAwMjnJFinzVo5CWAhUIwB3fA==
X-Google-Smtp-Source: ACHHUZ7C9K3ZOq8uMNAVNRGqwRq3cjh+jBqkPlZtFFIj52yBrPiJzm3KEY9nNs2ToYVi5vtErIP1Wg==
X-Received: by 2002:a5d:5252:0:b0:307:8548:f793 with SMTP id k18-20020a5d5252000000b003078548f793mr6945585wrc.53.1684743378459;
        Mon, 22 May 2023 01:16:18 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d4244000000b00307bc4e39e5sm6764094wrr.117.2023.05.22.01.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:16:18 -0700 (PDT)
Message-ID: <4e3a7b8f-b5e0-4f66-fa10-a37df0eee7c4@linaro.org>
Date:   Mon, 22 May 2023 10:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] global: Use proper project name U-Boot
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
        git@xilinx.com, Tom Rini <trini@konsulko.com>
Cc:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Harald Seiler <hws@denx.de>, Heiko Schocher <hs@denx.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Holger Brunck <holger.brunck@hitachienergy.com>,
        Igor Opaniuk <igor.opaniuk@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        =?UTF-8?Q?Javier_Mart=c3=adnez_Canillas?= <javier@dowhile0.org>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Kamil Lulko <kamil.lulko@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Luka Kovacic <luka.kovacic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Lukasz Majewski <lukma@denx.de>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Matthias Winker <matthias.winker@de.bosch.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Michael Walle <michael@walle.cc>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        Niel Fourie <lusus@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Philip Oberfichtner <pro@denx.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        =?UTF-8?Q?Pierre-Cl=c3=a9ment_Tosi?= <ptosi@google.com>,
        Qu Wenruo <wqu@suse.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Ramon Fried <rfried.dev@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Roger Knecht <rknecht@pm.me>,
        Sean Anderson <seanga2@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Simon Glass <sjg@chromium.org>,
        Stefan Bosch <stefan_b@posteo.net>, Stefan Roese <sr@denx.de>,
        Uri Mashiach <uri.mashiach@compulab.co.il>,
        Vikas Manocha <vikas.manocha@st.com>,
        Will Deacon <willdeacon@google.com>,
        linux-btrfs@vger.kernel.org, u-boot-amlogic@groups.io,
        uboot-snps-arc@synopsys.com,
        uboot-stm32@st-md-mailman.stormreply.com
References: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
Organization: Linaro Developer Services
In-Reply-To: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2023 09:17, Michal Simek wrote:
> Use proper project name in comments, Kconfig, readmes.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>


For amlogic changes:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


> ---
> 
> I am ignoring these for now because they can break automated scripts or
> user setting that's why they should be fixed separately.
> 

<snip>

> doc/board/amlogic/pre-generated-fip.rst:77:- bl33.bin: U-boot binary image

You can add this change safely,

Neil



<snip>

