Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258377060F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 09:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEQHSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEQHSU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 03:18:20 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE59110
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 00:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt9nuE7Uzj01pfwP+DEyAQCryCMEGD4aKKKS23Ha6suJDkooDtKoHQ0UXgl+ANQpOiQSqOmeO3G786m9jdSTDR0kMQwUuQjI1nVOtRCUrrrJynkp3qdr+8b8TspvWm/wVnIMaKiFG4FPvX+2HBDWGWtIB1x2B1hpUoElrFVRnIUdwdOH8OI9bsoOf8Z1N9KsUhEq2xFEzayd6JWS6wdjDP2f9qBviMHqZkl+aCL/r8xJ1s/F662pCixUfQGG8qWCD2cnqQDuG0Lr26DaWW3gP0wcKje+bPZxZ+ad5FYbZ8UQhFOL5iC+dcMZtUXm5SMmDzTy9pz9i7V2k8ClfZUP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQEmhjCwJZJXpA9jNtdfvWieIDC45k5KZxMizPErgT4=;
 b=jRhFDmaoy2bKN3E9qMhM2cIU7rYOGoIteXqB/RklCKbxMVvW75064NpznyXSAKBMcgKUJppWBaS7Zc86CHDmWGbVEQkrZ/sKQRv9Es+9SugXM10Msjat4MPOVPDt72SNVbZgd87akPiVWJ+YpJ1C5HJYC60L7k8cxQjA0aoaskiYJGDmlSOd7EvGftk7vs9GjiycJF6yjEbf68s+4r2TucKgtUYp1e88enDTQDC/fMVSXtNC3KQKFJURySW0qRjhgtLfr/vygbeeKSrR6W/XD8qlw0jAZdOPO61d/mALYJOazI2M/gxEvy8CprMdqhrHxMIuKLEJZ5n4CdobO0a4gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQEmhjCwJZJXpA9jNtdfvWieIDC45k5KZxMizPErgT4=;
 b=jc+fj48R/b814Wt+JRieuXyoiQ8+eZptn8OBr7VD+u/JkCKqv/bgov8SvNpJ1jmTXI/KO5SNmuVRbXqpLB5URxm4mwRhnwPUrOUfTfb9Su4Es3QmewmgOeWH0IOafI1PcV5kyJw242yNNTYpFfmV5IVO/mwaV+zSbZFz61PMRPY=
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 07:18:11 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::d3) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34 via Frontend
 Transport; Wed, 17 May 2023 07:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 07:18:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 02:17:19 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <u-boot@lists.denx.de>, <git@xilinx.com>,
        Tom Rini <trini@konsulko.com>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
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
        =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
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
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marek Vasut <marek.vasut+renesas@mailbox.org>,
        Matthias Winker <matthias.winker@de.bosch.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Michael Walle <michael@walle.cc>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Niel Fourie <lusus@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Philip Oberfichtner <pro@denx.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
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
        <linux-btrfs@vger.kernel.org>, <u-boot-amlogic@groups.io>,
        <uboot-snps-arc@synopsys.com>,
        <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] global: Use proper project name U-Boot
Date:   Wed, 17 May 2023 09:17:16 +0200
Message-ID: <0dbdf0432405c1c38ffca55703b6737a48219e79.1684307818.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=51961; i=michal.simek@amd.com; h=from:subject:message-id; bh=0ymU8d+z+VXxGujWvpl346dKSV5CRO/GCbnUEhwboCw=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpSU+ryO4v3TeMXmLt6f15H1ZPXbwDBzZ65ES6HNgXynW sUn+bl0xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIkoFzHMjzaVtXzUtvCW0p13 y4/vU5j8srvTk2Ge1f7MP6t8XtstuL/zn1hyhFDpJtcQAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|DM4PR12MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: b5be5a82-63d2-4e9d-7373-08db56a6def1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GM/wwaemDL07c0U4S0reAB4el5ucCRXWrA2V/ygZ/y79oqWBeqVdu21bhBOHYlxK/35hndrKOhjgo+LRc0I4NyCSkXDNNIvgEXDxuSy+EJ/SL/Gy4StfLwgXVihXsZZ/tAAsyXrdPuJjqCQfuheVQsdd4H9yyprz1i+fSOBT3BIVZoY2a/VM//4fioe6s4/G+TkGcVD0v6F3g3CBlaHfRgkh67Gh9b9hrxStfxDLQcWFtBiREKodLXY1TK/FHiScRZeDq+L3/yofVMz85fszVnD7UkKyfMJuhtw9YBTJdYm6+uLozJ7erpPG1BAXOUF+ioD6HDpFlFYY8UPQgAkrBzcQL78aAv6Pr+eRyQIXkoba/IWulR+gXj0Inf0GT0/RqwxpZE2WpDddaeLO4x8VwZl/ZucDv+VtZF+phDCRI3cwLLpqVvdHZmG89VhiuM6D7lWf9MDLjjKY5nlVDLQH0JxF2eC+SCi/TrImJcWi4To5Nn5u83PupJ6GHmMe0FZYSSHmpl7gzXMJEJ1jr6MNFYevcgKbIp6z/XsYJjJa2DZqEvQvEIqReFHkWU10yhDn7ETKFe6ltoxeGDE0AsWcT5qFMvT7yFjswLPKHSdjGMa2gs7JW36XQmiW0zjhASkh+tuD5NSZVYi1B0gCCdwoJcny9pc3zl1lpypGQ4/eUpCE8bLLxvwrmSobcJ/ahZQf3l0KSehmz00f6wDSbQF0nXjEzSgT3Gf/vbVxdroeTfrymHsrWkVHR8V0AKSnHsPRxdoDJIi67Fcq47r4W++jrO+bBm8ZK4YOmV/zaVUY5DUrC+XVxQQPtGaVpyvesgRrLrmysSsM+lTOk5lPBDjWXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(40460700003)(26005)(966005)(36756003)(36860700001)(32650700002)(40480700001)(83380400001)(2616005)(426003)(336012)(86362001)(15974865002)(82310400005)(356005)(81166007)(82740400003)(186003)(16526019)(2906002)(30864003)(478600001)(4326008)(316002)(44832011)(7416002)(7366002)(7406005)(8936002)(54906003)(110136005)(5660300002)(8676002)(70586007)(70206006)(6666004)(41300700001)(36900700001)(579004)(559001)(139555002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 07:18:10.7045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5be5a82-63d2-4e9d-7373-08db56a6def1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use proper project name in comments, Kconfig, readmes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

I am ignoring these for now because they can break automated scripts or
user setting that's why they should be fixed separately.

arch/arm/dts/am335x-igep0033.dtsi:178:                  label = "U-boot";
arch/arm/dts/armada-3720-db.dts:183:                            label = "U-boot Env";
board/armadeus/opos6uldev/opos6uldev.env:45:                    echo Flashing of U-boot SPL succeed;
board/armadeus/opos6uldev/opos6uldev.env:46:            else echo Flashing of U-boot SPL failed;
board/armadeus/opos6uldev/opos6uldev.env:55:                    echo Flashing of U-boot image succeed;
board/armadeus/opos6uldev/opos6uldev.env:56:            else echo Flashing of U-boot image failed;
board/freescale/common/fsl_chain_of_trust.c:130:                printf("SPL: Validation of U-boot successful\n");
board/freescale/ls1012afrdm/README:55:U-boot            | 1MB   | 0x4010_0000
board/freescale/ls1012afrdm/README:56:U-boot Env        | 1MB   | 0x4020_0000
board/freescale/ls1012aqds/README:56:U-boot             | 1MB   | 0x4010_0000
board/freescale/ls1012aqds/README:57:U-boot Env | 1MB   | 0x4020_0000
board/freescale/ls1012ardb/README:51:U-boot             | 1MB   | 0x4010_0000
board/freescale/ls1012ardb/README:52:U-boot Env | 1MB   | 0x4020_0000
board/freescale/ls1012ardb/README:93:U-boot             | 1MB   | 0x4010_0000
board/freescale/ls1012ardb/README:94:U-boot Env | 1MB   | 0x4030_0000
board/imgtec/boston/checkboard.c:19:    lowlevel_display("U-boot  ");
doc/board/amlogic/pre-generated-fip.rst:77:- bl33.bin: U-boot binary image
include/dt-bindings/memory/bcm-ns3-mc.h:31:/* ATF/U-boot/Linux error logs */
net/dhcpv6.h:41:#define DHCP6_VCI_STRING        "U-boot"

---
 arch/Kconfig.nxp                               |  2 +-
 arch/arc/include/asm/io.h                      |  2 +-
 arch/arm/cpu/armv7/Kconfig                     |  2 +-
 arch/arm/cpu/armv8/Kconfig                     |  2 +-
 .../cpu/armv8/fsl-layerscape/doc/README.lsch3  |  2 +-
 arch/arm/dts/fsl-ls1028a.dtsi                  |  2 +-
 arch/arm/dts/meson-g12-common-u-boot.dtsi      |  2 +-
 arch/arm/dts/meson-gx-u-boot.dtsi              |  2 +-
 arch/arm/dts/rk3328-evb-u-boot.dtsi            |  2 +-
 arch/arm/dts/rk3328.dtsi                       |  2 +-
 .../asm/arch-fsl-layerscape/stream_id_lsch2.h  |  2 +-
 .../asm/arch-fsl-layerscape/stream_id_lsch3.h  |  2 +-
 board/bosch/acc/acc.c                          |  2 +-
 board/bosch/shc/README                         |  2 +-
 board/compulab/cl-som-imx7/cl-som-imx7.c       |  2 +-
 board/hisilicon/poplar/README                  |  2 +-
 board/isee/igep003x/board.c                    |  2 +-
 board/isee/igep00x0/igep00x0.c                 |  2 +-
 board/keymile/Kconfig                          |  8 ++++----
 board/keymile/README                           |  2 +-
 board/kontron/sl-mx6ul/spl.c                   |  2 +-
 board/phytec/pcm058/README                     | 18 +++++++++---------
 board/synopsys/hsdk/hsdk.c                     | 14 +++++++-------
 boot/boot_fit.c                                |  2 +-
 cmd/ufs.c                                      |  2 +-
 common/spl/spl.c                               |  2 +-
 common/spl/spl_mmc.c                           |  2 +-
 doc/README.pcap                                |  2 +-
 doc/README.s5p4418                             |  2 +-
 doc/SPL/README.spl-secure-boot                 |  4 ++--
 doc/board/amlogic/p201.rst                     |  2 +-
 doc/board/amlogic/p212.rst                     |  2 +-
 doc/board/amlogic/s400.rst                     |  2 +-
 doc/board/emulation/qemu-arm.rst               |  2 +-
 doc/board/nxp/ls1046ardb.rst                   |  2 +-
 doc/board/nxp/mx6sabresd.rst                   |  2 +-
 doc/board/rockchip/rockchip.rst                |  6 +++---
 doc/board/sifive/unmatched.rst                 |  2 +-
 doc/board/st/stm32mp1.rst                      |  2 +-
 doc/board/xen/xenguest_arm64.rst               | 10 +++++-----
 doc/develop/driver-model/bind.rst              |  2 +-
 .../driver-model/fs_firmware_loader.rst        |  6 +++---
 doc/develop/uefi/uefi.rst                      |  2 +-
 doc/usage/cmd/source.rst                       |  2 +-
 doc/usage/dfu.rst                              |  2 +-
 drivers/clk/clk-mux.c                          |  2 +-
 drivers/gpio/gpio-fxl6408.c                    |  2 +-
 drivers/mtd/nand/raw/Kconfig                   |  6 +++---
 drivers/mtd/nand/raw/fsl_ifc_spl.c             |  4 ++--
 drivers/net/pfe_eth/pfe_hw.c                   |  2 +-
 drivers/phy/marvell/comphy_cp110.c             |  2 +-
 drivers/spi/spi-qup.c                          |  2 +-
 dts/Kconfig                                    |  4 ++--
 fs/btrfs/compat.h                              |  2 +-
 fs/btrfs/extent-io.h                           |  2 +-
 include/fsl_validate.h                         |  4 ++--
 include/zynqmp_firmware.h                      |  2 +-
 test/py/tests/test_android/test_avb.py         |  2 +-
 test/py/tests/test_cat/conftest.py             |  2 +-
 test/py/tests/test_efi_bootmgr/conftest.py     |  2 +-
 test/py/tests/test_efi_capsule/conftest.py     |  2 +-
 test/py/tests/test_efi_secboot/conftest.py     |  4 ++--
 test/py/tests/test_eficonfig/conftest.py       |  2 +-
 test/py/tests/test_fs/conftest.py              | 12 ++++++------
 test/py/tests/test_scp03.py                    |  2 +-
 test/py/tests/test_xxd/conftest.py             |  2 +-
 66 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index 6e1c44b7ea82..e75226bc434c 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -90,7 +90,7 @@ config SPL_UBOOT_KEY_HASH
 	default ""
 	help
 	  Set the key hash for U-Boot here if public/private key pair used to
-	  sign U-boot are different from the SRK hash put in the fuse.  Example
+	  sign U-Boot are different from the SRK hash put in the fuse.  Example
 	  of a key hash is
 	  41066b564c6ffcef40ccbc1e0a5d0d519604000c785d97bbefd25e4d288d1c8b.
 	  Otherwise leave this empty.
diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
index 6adc0ed42bac..c818b8bdaec0 100644
--- a/arch/arc/include/asm/io.h
+++ b/arch/arc/include/asm/io.h
@@ -80,7 +80,7 @@ static inline void sync(void)
 
 /*
  * We add memory barriers for __raw_readX / __raw_writeX accessors same way as
- * it is done for readX and writeX accessors as lots of U-boot driver uses
+ * it is done for readX and writeX accessors as lots of U-Boot driver uses
  * __raw_readX / __raw_writeX instead of proper accessor with barrier.
  */
 #define __raw_writeb(v, c)	({ __iowmb(); __arch_putb(v, c); })
diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index e33e53636a01..ccc2f2086770 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -110,7 +110,7 @@ config ARMV7_LPAE
 config ARMV7_SET_CORTEX_SMPEN
 	bool
 	help
-	  Enable the ARM Cortex ACTLR.SMP enable bit in U-boot.
+	  Enable the ARM Cortex ACTLR.SMP enable bit in U-Boot.
 
 config SPL_ARMV7_SET_CORTEX_SMPEN
 	bool
diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index 7d5cf1594dad..9f0fb369f773 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -145,7 +145,7 @@ config ARMV8_PSCI
 	bool "Enable PSCI support" if EXPERT
 	help
 	  PSCI is Power State Coordination Interface defined by ARM.
-	  The PSCI in U-boot provides a general framework and each platform
+	  The PSCI in U-Boot provides a general framework and each platform
 	  can implement their own specific PSCI functions.
 	  Say Y here to enable PSCI support on ARMv8 platform.
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.lsch3 b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.lsch3
index 6f3fe7ca6e08..1ddf9473a30a 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.lsch3
+++ b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.lsch3
@@ -125,7 +125,7 @@ mcinitcmd:	This environment variable is defined to initiate MC and DPL deploymen
 		from the location where it is stored(NOR, NAND, SD, SATA, USB)during
 		u-boot booting.If this variable is not defined then MC_BOOT_ENV_VAR
 		will be null and MC will not be booted and DPL will not be applied
-		during U-boot booting.However the MC, DPC and DPL can be applied from
+		during U-Boot booting.However the MC, DPC and DPL can be applied from
 		console independently.
 		The variable needs to be set from the console once and then on
 		rebooting the parameters set in the variable will automatically be
diff --git a/arch/arm/dts/fsl-ls1028a.dtsi b/arch/arm/dts/fsl-ls1028a.dtsi
index 06b36cc65865..dde0c4091f18 100644
--- a/arch/arm/dts/fsl-ls1028a.dtsi
+++ b/arch/arm/dts/fsl-ls1028a.dtsi
@@ -51,7 +51,7 @@
 
 	idle-states {
 		/*
-		 * PSCI node is not added default, U-boot will add missing
+		 * PSCI node is not added default, U-Boot will add missing
 		 * parts if it determines to use PSCI.
 		 */
 		entry-method = "psci";
diff --git a/arch/arm/dts/meson-g12-common-u-boot.dtsi b/arch/arm/dts/meson-g12-common-u-boot.dtsi
index efa6a0570bdb..8070b62af5ba 100644
--- a/arch/arm/dts/meson-g12-common-u-boot.dtsi
+++ b/arch/arm/dts/meson-g12-common-u-boot.dtsi
@@ -5,7 +5,7 @@
  */
 
 / {
-	/* Keep HW order from U-boot */
+	/* Keep HW order from U-Boot */
 	aliases {
 		/delete-property/ mmc0;
 		/delete-property/ mmc1;
diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u-boot.dtsi
index 9f123ab04214..9e0620f395e8 100644
--- a/arch/arm/dts/meson-gx-u-boot.dtsi
+++ b/arch/arm/dts/meson-gx-u-boot.dtsi
@@ -5,7 +5,7 @@
  */
 
 / {
-	/* Keep HW order from U-boot */
+	/* Keep HW order from U-Boot */
 	aliases {
 		/delete-property/ mmc0;
 		/delete-property/ mmc1;
diff --git a/arch/arm/dts/rk3328-evb-u-boot.dtsi b/arch/arm/dts/rk3328-evb-u-boot.dtsi
index 4bfa0c2330ba..95e497970eec 100644
--- a/arch/arm/dts/rk3328-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3328-evb-u-boot.dtsi
@@ -41,7 +41,7 @@
 };
 
 &gmac2phy {
-	/* Integrated PHY unsupported by U-boot */
+	/* Integrated PHY unsupported by U-Boot */
 	status = "broken";
 };
 
diff --git a/arch/arm/dts/rk3328.dtsi b/arch/arm/dts/rk3328.dtsi
index 27e45d5886aa..e8d8f00be8aa 100644
--- a/arch/arm/dts/rk3328.dtsi
+++ b/arch/arm/dts/rk3328.dtsi
@@ -984,7 +984,7 @@
 	};
 
 	/*
-	 * U-boot Specific Change
+	 * U-Boot Specific Change
 	 *
 	 * The OTG controller must come after the USB host pair for it
 	 * to work. This is likely due to lack of support for the USB
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h
index 1b02d484d988..c18c51ed2c7c 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch2.h
@@ -22,7 +22,7 @@
  *
  *  -PCIe
  *     -there is a range of stream IDs set aside for PCI in this
- *      file.  U-boot will scan the PCI bus and for each device discovered:
+ *      file.  U-Boot will scan the PCI bus and for each device discovered:
  *         -allocate a streamID
  *         -set a PEXn LUT table entry mapping 'requester ID' to 'stream ID'
  *         -set a msi-map entry in the PEXn controller node in the
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h
index b36b6d3889f4..140849d4e1fb 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/stream_id_lsch3.h
@@ -23,7 +23,7 @@
  *
  *  -PCIe
  *     -there is a range of stream IDs set aside for PCI in this
- *      file.  U-boot will scan the PCI bus and for each device discovered:
+ *      file.  U-Boot will scan the PCI bus and for each device discovered:
  *         -allocate a streamID
  *         -set a PEXn LUT table entry mapping 'requester ID' to 'stream ID'
  *         -set a msi-map entry in the PEXn controller node in the
diff --git a/board/bosch/acc/acc.c b/board/bosch/acc/acc.c
index 4a0603d0f3f6..62388b345e12 100644
--- a/board/bosch/acc/acc.c
+++ b/board/bosch/acc/acc.c
@@ -559,7 +559,7 @@ int board_mmc_init(struct bd_info *bis)
 	gpio_direction_input(USDHC2_CD_GPIO);
 	/*
 	 * According to the board_mmc_init() the following map is done:
-	 * (U-boot device node) (Physical Port)
+	 * (U-Boot device node) (Physical Port)
 	 * mmc0 USDHC2
 	 * mmc1 USDHC4
 	 */
diff --git a/board/bosch/shc/README b/board/bosch/shc/README
index 2f206e0d5515..74704cdc1153 100644
--- a/board/bosch/shc/README
+++ b/board/bosch/shc/README
@@ -68,7 +68,7 @@ Netboot
 - see also doc/SPL/README.am335x-network
 
 - set the jumper into netboot mode
-- compile the U-boot sources with:
+- compile the U-Boot sources with:
   make am335x_shc_netboot_defconfig
   make all
 - copy the images into your tftp boot directory
diff --git a/board/compulab/cl-som-imx7/cl-som-imx7.c b/board/compulab/cl-som-imx7/cl-som-imx7.c
index 1b08a2c5abf2..af19a658b542 100644
--- a/board/compulab/cl-som-imx7/cl-som-imx7.c
+++ b/board/compulab/cl-som-imx7/cl-som-imx7.c
@@ -86,7 +86,7 @@ int board_mmc_init(struct bd_info *bis)
 	int i, ret;
 	/*
 	 * According to the board_mmc_init() the following map is done:
-	 * (U-boot device node)    (Physical Port)
+	 * (U-Boot device node)    (Physical Port)
 	 * mmc0                    USDHC1
 	 * mmc2                    USDHC3 (eMMC)
 	 */
diff --git a/board/hisilicon/poplar/README b/board/hisilicon/poplar/README
index 99ed6ce295e0..77dcc3ba1152 100644
--- a/board/hisilicon/poplar/README
+++ b/board/hisilicon/poplar/README
@@ -30,7 +30,7 @@ CONNECTORS  One connector for Smart Card One connector for TSI
 Note of warning:
 ================
 
-U-boot has a *strong* dependency with the l-loader and the arm trusted firmware
+U-Boot has a *strong* dependency with the l-loader and the arm trusted firmware
 repositories.
 
 The boot sequence is:
diff --git a/board/isee/igep003x/board.c b/board/isee/igep003x/board.c
index 5462a3dea228..7dbb08008927 100644
--- a/board/isee/igep003x/board.c
+++ b/board/isee/igep003x/board.c
@@ -37,7 +37,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 /* GPIO0_27 and GPIO0_26 are used to read board revision from IGEP003x boards
  * and control IGEP0034 green and red LEDs.
- * U-boot configures these pins as input pullup to detect board revision:
+ * U-Boot configures these pins as input pullup to detect board revision:
  * IGEP0034-LITE = 0b00
  * IGEP0034 (FULL) = 0b01
  * IGEP0033 = 0b1X
diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index f1599306e618..0f0a9c592fcc 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -47,7 +47,7 @@ U_BOOT_DRVINFO(igep_uart) = {
  * IGEP00x0 boards. First of all, it is necessary to reset USB transceiver from
  * IGEP0030 in order to read GPIO_IGEP00X0_BOARD_DETECTION correctly, because
  * this functionality is shared by USB HOST.
- * Once USB reset is applied, U-boot configures these pins as input pullup to
+ * Once USB reset is applied, U-Boot configures these pins as input pullup to
  * detect board and revision:
  * IGEP0020-RF = 0b00
  * IGEP0020-RC = 0b01
diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
index bf899d005c46..c6576aa6523a 100644
--- a/board/keymile/Kconfig
+++ b/board/keymile/Kconfig
@@ -123,7 +123,7 @@ config SYS_IVM_EEPROM_PAGE_LEN
 	  Page size of inventory in EEPROM.
 
 config PG_WCOM_UBOOT_UPDATE_SUPPORTED
-	bool "Enable U-boot Field Fail-Safe Update Functionality"
+	bool "Enable U-Boot Field Fail-Safe Update Functionality"
 	select EVENT
 	default n
 	help
@@ -132,7 +132,7 @@ config PG_WCOM_UBOOT_UPDATE_SUPPORTED
 	  from parallel NOR flash.
 
 config PG_WCOM_UBOOT_BOOTPACKAGE
-	bool "U-boot Is Part Of Factory Boot-Package Image"
+	bool "U-Boot Is Part Of Factory Boot-Package Image"
 	default n
 	help
 	  Indicates that u-boot will be a part of the factory programmed
@@ -140,7 +140,7 @@ config PG_WCOM_UBOOT_BOOTPACKAGE
 	  Has to be set for original u-boot programmed at factory.
 
 config PG_WCOM_UBOOT_UPDATE_TEXT_BASE
-	hex "Text Base For U-boot Programmed Outside Factory"
+	hex "Text Base For U-Boot Programmed Outside Factory"
 	default 0xFFFFFFFF
 	help
 	  Text base of an updated u-boot that is not factory programmed but
@@ -148,7 +148,7 @@ config PG_WCOM_UBOOT_UPDATE_TEXT_BASE
 	  Has to be set for original u-boot programmed at factory.
 
 config PG_WCOM_UBOOT_UPDATE
-	bool "U-boot Is Part Of Factory Boot-Package Image"
+	bool "U-Boot Is Part Of Factory Boot-Package Image"
 	default n
 	help
 	  Indicates that u-boot will be a part of the embedded software and
diff --git a/board/keymile/README b/board/keymile/README
index 4e5cfb142a39..99f27e576aaf 100644
--- a/board/keymile/README
+++ b/board/keymile/README
@@ -1,4 +1,4 @@
-Field Fail-Save U-boot Update
+Field Fail-Save U-Boot Update
 -----------------------------
 Field Fail-Save u-boot update is a feature that allows save u-boot update
 of FOX and XMC products that are rolled out in the field.
diff --git a/board/kontron/sl-mx6ul/spl.c b/board/kontron/sl-mx6ul/spl.c
index bae0e70a657d..a9d370bc854c 100644
--- a/board/kontron/sl-mx6ul/spl.c
+++ b/board/kontron/sl-mx6ul/spl.c
@@ -101,7 +101,7 @@ int board_mmc_init(struct bd_info *bis)
 
 	/*
 	 * According to the board_mmc_init() the following map is done:
-	 * (U-boot device node)    (Physical Port)
+	 * (U-Boot device node)    (Physical Port)
 	 * mmc0                    USDHC1
 	 * mmc1                    USDHC2
 	 */
diff --git a/board/phytec/pcm058/README b/board/phytec/pcm058/README
index 687366bffbd7..4b6984cd54fe 100644
--- a/board/phytec/pcm058/README
+++ b/board/phytec/pcm058/README
@@ -37,12 +37,12 @@ not supported.
 Flashing U-Boot onto an SD card
 -------------------------------
 
-After a successful build, the generated SPL and U-boot binaries can be copied
+After a successful build, the generated SPL and U-Boot binaries can be copied
 to an SD card. Adjust the SD card device as necessary:
 
 $ sudo dd if=u-boot-with-spl.imx of=/dev/mmcblk0 bs=1k seek=1
 
-This is equivalent to separately copying the SPL and U-boot using:
+This is equivalent to separately copying the SPL and U-Boot using:
 
 $ sudo dd if=SPL of=/dev/mmcblk0 bs=1k seek=1
 $ sudo dd if=u-boot-dtb.img of=/dev/mmcblk0 bs=1k seek=197
@@ -50,11 +50,11 @@ $ sudo dd if=u-boot-dtb.img of=/dev/mmcblk0 bs=1k seek=197
 The default bootscripts expect a kernel fit-image file named "fitImage" in the
 first partition and Linux ext4 rootfs in the second partition.
 
-Flashing U-boot to the SPI Flash, for booting Linux from NAND
+Flashing U-Boot to the SPI Flash, for booting Linux from NAND
 -------------------------------------------------------------
 
-The SD card created above can also be used to install the SPL and U-boot into
-the SPI flash. Boot U-boot from the SD card as above, and stop at the autoboot.
+The SD card created above can also be used to install the SPL and U-Boot into
+the SPI flash. Boot U-Boot from the SD card as above, and stop at the autoboot.
 
 Then, clear the SPI flash:
 
@@ -64,13 +64,13 @@ Then, clear the SPI flash:
 Load the equivalent of u-boot-with-spl.imx from the raw MMC into memory and
 copy to the SPI. The SPL is expected at an offset of 0x400, and its size is
 maximum 392*512-byte blocks in size, therefore 0x188 blocks, totaling 0x31000
-bytes. Assume U-boot should fit into 640KiB, therefore 0x500 512-byte blocks,
+bytes. Assume U-Boot should fit into 640KiB, therefore 0x500 512-byte blocks,
 totalling 0xA0000 bytes. Adding these together:
 
 => mmc read ${loadaddr} 0x2 0x688
 => sf write ${loadaddr} 0x400 0xD1000
 
-The SPL is located at offset 0x400, and U-boot at 0x31400 in SPI flash, as to
+The SPL is located at offset 0x400, and U-Boot at 0x31400 in SPI flash, as to
 match the SD Card layout. This would allow, instead of reading from the SD Card
 above, with networking and TFTP correctly configured, the equivalent of:
 
@@ -84,7 +84,7 @@ image) and "root" (which contains a ubifs root filesystem).
 The "bootm_size" variable in the environment
 --------------------------------------------
 
-By default, U-boot relocates the device tree towards the upper end of the RAM,
+By default, U-Boot relocates the device tree towards the upper end of the RAM,
 which kernels using CONFIG_HIGHMEM=y may not be able to access during early
-boot. With the bootm_size variable set to 0x30000000, U-boot relocates the
+boot. With the bootm_size variable set to 0x30000000, U-Boot relocates the
 device tree to below this address instead.
diff --git a/board/synopsys/hsdk/hsdk.c b/board/synopsys/hsdk/hsdk.c
index 4308c7e440aa..6cbc89ae7874 100644
--- a/board/synopsys/hsdk/hsdk.c
+++ b/board/synopsys/hsdk/hsdk.c
@@ -583,7 +583,7 @@ enum hsdk_axi_masters {
  *
  * Please read ARC HS Development IC Specification, section 17.2 for more
  * information about apertures configuration.
- * NOTE: we intentionally modify default settings in U-boot. Default settings
+ * NOTE: we intentionally modify default settings in U-Boot. Default settings
  * are specified in "Table 111 CREG Address Decoder register reset values".
  */
 
@@ -942,7 +942,7 @@ static int do_hsdk_go(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	if (board_mismatch()) {
-		printf("ERR: U-boot is not configured for this board!\n");
+		printf("ERR: U-Boot is not configured for this board!\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -983,10 +983,10 @@ U_BOOT_CMD(
 
 /*
  * We may simply use static variable here to store init status, but we also want
- * to avoid the situation when we reload U-boot via MDB after previous
+ * to avoid the situation when we reload U-Boot via MDB after previous
  * init is done but HW reset (board reset) isn't done. So let's store the
  * init status in any unused register (i.e CREG_CPU_0_ENTRY) so status will
- * survive after U-boot is reloaded via MDB.
+ * survive after U-Boot is reloaded via MDB.
  */
 #define INIT_MARKER_REGISTER		((void __iomem *)CREG_CPU_0_ENTRY)
 /* must be equal to INIT_MARKER_REGISTER reset value */
@@ -1008,7 +1008,7 @@ static int do_hsdk_init(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	if (board_mismatch()) {
-		printf("ERR: U-boot is not configured for this board!\n");
+		printf("ERR: U-Boot is not configured for this board!\n");
 		return CMD_RET_FAILURE;
 	}
 
@@ -1258,11 +1258,11 @@ int checkboard(void)
 	printf("Board: Synopsys %s\n", board_name(get_board_type_runtime()));
 
 	if (board_mismatch())
-		printf("WARN: U-boot is configured NOT for this board but for %s!\n",
+		printf("WARN: U-Boot is configured NOT for this board but for %s!\n",
 		       board_name(get_board_type_config()));
 
 	reg = readl(CREG_AXI_M_HS_CORE_BOOT) & CREG_CORE_BOOT_IMAGE;
-	printf("U-boot autostart: %s\n", reg ? "enabled" : "disabled");
+	printf("U-Boot autostart: %s\n", reg ? "enabled" : "disabled");
 
 	return 0;
 };
diff --git a/boot/boot_fit.c b/boot/boot_fit.c
index 4a493b368472..9d3941265636 100644
--- a/boot/boot_fit.c
+++ b/boot/boot_fit.c
@@ -67,7 +67,7 @@ void *locate_dtb_in_fit(const void *fit)
 	header = (struct legacy_img_hdr *)fit;
 
 	if (image_get_magic(header) != FDT_MAGIC) {
-		debug("No FIT image appended to U-boot\n");
+		debug("No FIT image appended to U-Boot\n");
 		return NULL;
 	}
 
diff --git a/cmd/ufs.c b/cmd/ufs.c
index d4a1e66c1bde..143e946370f8 100644
--- a/cmd/ufs.c
+++ b/cmd/ufs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /**
- * ufs.c - UFS specific U-boot commands
+ * ufs.c - UFS specific U-Boot commands
  *
  * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
  *
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 72078a8ebc8e..28124a8bdf6e 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -321,7 +321,7 @@ static int spl_load_fit_image(struct spl_image_info *spl_image,
 		spl_image->fdt_addr = (void *)dt_data;
 
 		if (spl_image->os == IH_OS_U_BOOT) {
-			/* HACK: U-boot expects FDT at a specific address */
+			/* HACK: U-Boot expects FDT at a specific address */
 			fdt_hack = spl_image->load_addr + spl_image->size;
 			fdt_hack = (fdt_hack + 3) & ~3;
 			debug("Relocating FDT to %p\n", spl_image->fdt_addr);
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index a0722167044f..a665091b00f5 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -250,7 +250,7 @@ static int mmc_load_image_raw_os(struct spl_image_info *spl_image,
 		return ret;
 
 	if (spl_image->os != IH_OS_LINUX && spl_image->os != IH_OS_TEE) {
-		puts("Expected image is not found. Trying to start U-boot\n");
+		puts("Expected image is not found. Trying to start U-Boot\n");
 		return -ENOENT;
 	}
 
diff --git a/doc/README.pcap b/doc/README.pcap
index 8e30b93c663f..10318ef0a9e3 100644
--- a/doc/README.pcap
+++ b/doc/README.pcap
@@ -1,6 +1,6 @@
 PCAP:
 
-U-boot supports live Ethernet packet capture in PCAP(2.4) format.
+U-Boot supports live Ethernet packet capture in PCAP(2.4) format.
 This is enabled by CONFIG_CMD_PCAP.
 
 The capture is stored on physical memory, and should be copied to
diff --git a/doc/README.s5p4418 b/doc/README.s5p4418
index ac724d08a04c..8ec7b05fd266 100644
--- a/doc/README.s5p4418
+++ b/doc/README.s5p4418
@@ -38,7 +38,7 @@ The source code for (the used?) LUbuntu 16.04 can be found at [5].
 Links
 =====
 
-[1] FriendlyArm U-boot v2016.01:
+[1] FriendlyArm U-Boot v2016.01:
 
 https://github.com/friendlyarm/u-boot/tree/nanopi2-v2016.01
 
diff --git a/doc/SPL/README.spl-secure-boot b/doc/SPL/README.spl-secure-boot
index f2f8d7888374..982fbec654db 100644
--- a/doc/SPL/README.spl-secure-boot
+++ b/doc/SPL/README.spl-secure-boot
@@ -12,7 +12,7 @@ Methodology
 
 The SPL image is responsible for loading the next stage boot loader, which is
 the main u-boot image. For secure boot process on these platforms ROM verifies
-SPL image, so to continue chain of trust SPL image verifies U-boot image using
+SPL image, so to continue chain of trust SPL image verifies U-Boot image using
 spl_validate_uboot(). This function uses QorIQ Trust Architecture header
-(appended to U-boot image) to validate the U-boot binary just before passing
+(appended to U-Boot image) to validate the U-Boot binary just before passing
 control to it.
diff --git a/doc/board/amlogic/p201.rst b/doc/board/amlogic/p201.rst
index 28aae98d990f..13b732fc7e40 100644
--- a/doc/board/amlogic/p201.rst
+++ b/doc/board/amlogic/p201.rst
@@ -56,7 +56,7 @@ image but sources have been shared by Linux development contractor, Baylibre:
     $ make
     $ export FIPDIR=$PWD/fip
 
-Go back to mainline U-boot source tree then :
+Go back to mainline U-Boot source tree then :
 
 .. code-block:: bash
 
diff --git a/doc/board/amlogic/p212.rst b/doc/board/amlogic/p212.rst
index c1b73e83b176..a872f32f0f49 100644
--- a/doc/board/amlogic/p212.rst
+++ b/doc/board/amlogic/p212.rst
@@ -50,7 +50,7 @@ the git tree published by the board vendor:
     $ make
     $ export FIPDIR=$PWD/fip
 
-Go back to mainline U-boot source tree then :
+Go back to mainline U-Boot source tree then :
 
 .. code-block:: bash
 
diff --git a/doc/board/amlogic/s400.rst b/doc/board/amlogic/s400.rst
index 59dda823755d..205e7c38fa31 100644
--- a/doc/board/amlogic/s400.rst
+++ b/doc/board/amlogic/s400.rst
@@ -56,7 +56,7 @@ image but sources have been shared by Linux development contractor, Baylibre:
     $ make
     $ export FIPDIR=$PWD/fip
 
-Go back to mainline U-boot source tree then :
+Go back to mainline U-Boot source tree then :
 
 .. code-block:: bash
 
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 16f66388eb1f..b42d924cc66a 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -54,7 +54,7 @@ Note that for some odd reason qemu-system-aarch64 needs to be explicitly
 told to use a 64-bit CPU or it will boot in 32-bit mode. The -nographic argument
 ensures that output appears on the terminal. Use Ctrl-A X to quit.
 
-Additional persistent U-boot environment support can be added as follows:
+Additional persistent U-Boot environment support can be added as follows:
 
 - Create envstore.img using qemu-img::
 
diff --git a/doc/board/nxp/ls1046ardb.rst b/doc/board/nxp/ls1046ardb.rst
index 35465d006121..49b4842b3064 100644
--- a/doc/board/nxp/ls1046ardb.rst
+++ b/doc/board/nxp/ls1046ardb.rst
@@ -150,7 +150,7 @@ Then, launch openocd like::
 
     openocd -f u-boot.tcl
 
-You should see the U-boot SPL banner followed by the banner for U-Boot proper
+You should see the U-Boot SPL banner followed by the banner for U-Boot proper
 in the output of openocd. The CMSIS-DAP adapter is slow, so this can take a
 long time. If you don't see it, something has gone wrong. After a while, you
 should see the prompt. You can load an image using semihosting by running::
diff --git a/doc/board/nxp/mx6sabresd.rst b/doc/board/nxp/mx6sabresd.rst
index fe15ba7b798e..c9869f4a73a2 100644
--- a/doc/board/nxp/mx6sabresd.rst
+++ b/doc/board/nxp/mx6sabresd.rst
@@ -53,7 +53,7 @@ This will generate the SPL and u-boot-dtb.img binaries.
 
 - Boot first from SD card as shown in the previous section
 
-In U-boot change the eMMC partition config::
+In U-Boot change the eMMC partition config::
 
    => mmc partconf 2 1 0 0
 
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 99376fb54c90..4c555e1c9c1e 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -333,12 +333,12 @@ Note:
 
 Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
 If all other boot options fail then it enters into a BootROM mode on the USB OTG port.
-This method loads TPL/SPL on NAND with U-boot and kernel on SD card.
+This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
 
 SD Card
 ^^^^^^^
 
-U-boot expects a GPT partition map and a boot directory structure with files on the SD card.
+U-Boot expects a GPT partition map and a boot directory structure with files on the SD card.
 
 .. code-block:: none
 
@@ -363,7 +363,7 @@ Boot partition:
         zImage
         rk3066a-mk808.dtb
 
-To write a U-boot image to the SD card (assumed to be /dev/sda):
+To write a U-Boot image to the SD card (assumed to be /dev/sda):
 
 .. code-block:: bash
 
diff --git a/doc/board/sifive/unmatched.rst b/doc/board/sifive/unmatched.rst
index de2aab59bb16..c515949066fe 100644
--- a/doc/board/sifive/unmatched.rst
+++ b/doc/board/sifive/unmatched.rst
@@ -558,7 +558,7 @@ for partitions one through three respectively.
 	    --new=3:10280:10535 --change-name=3:env   --typecode=3:3DE21764-95BD-54BD-A5C3-4ABE786F38A8 \
 	    /dev/mtdblock0
 
-Write U-boot SPL and U-boot to their partitions.
+Write U-Boot SPL and U-Boot to their partitions.
 
 .. code-block:: none
 
diff --git a/doc/board/st/stm32mp1.rst b/doc/board/st/stm32mp1.rst
index c0b1daa0418e..63b44776ffc1 100644
--- a/doc/board/st/stm32mp1.rst
+++ b/doc/board/st/stm32mp1.rst
@@ -345,7 +345,7 @@ Build Procedure
         - BL33=u-boot-nodtb.bin
         - BL33_CFG=u-boot.dtb
 
-     You can also update a existing FIP after U-boot compilation with fiptool,
+     You can also update a existing FIP after U-Boot compilation with fiptool,
      a tool provided by TF-A_::
 
      # fiptool update --nt-fw u-boot-nodtb.bin --hw-config u-boot.dtb fip-stm32mp157c-ev1.bin
diff --git a/doc/board/xen/xenguest_arm64.rst b/doc/board/xen/xenguest_arm64.rst
index 1327f88f9908..e9bdaf7ffb2a 100644
--- a/doc/board/xen/xenguest_arm64.rst
+++ b/doc/board/xen/xenguest_arm64.rst
@@ -6,7 +6,7 @@ Xen guest ARM64 board
 This board specification
 ------------------------
 
-This board is to be run as a virtual Xen [1] guest with U-boot as its primary
+This board is to be run as a virtual Xen [1] guest with U-Boot as its primary
 bootloader. Xen is a type 1 hypervisor that allows multiple operating systems
 to run simultaneously on a single physical server. Xen is capable of running
 virtual machines in both full virtualization and para-virtualization (PV)
@@ -16,7 +16,7 @@ Paravirtualized drivers are a special type of device drivers that are used in
 a guest system in the Xen domain and perform I/O operations using a special
 interface provided by the virtualization system and the host system.
 
-Xen support for U-boot is implemented by introducing a new Xen guest ARM64
+Xen support for U-Boot is implemented by introducing a new Xen guest ARM64
 board and porting essential drivers from MiniOS [3] as well as some of the work
 previously done by NXP [4]:
 
@@ -39,7 +39,7 @@ previously done by NXP [4]:
 Board limitations
 -----------------
 
-1. U-boot runs without MMU enabled at the early stages.
+1. U-Boot runs without MMU enabled at the early stages.
    According to Xen on ARM ABI (xen/include/public/arch-arm.h): all memory
    which is shared with other entities in the system (including the hypervisor
    and other guests) must reside in memory which is mapped as Normal Inner
@@ -54,14 +54,14 @@ Board limitations
 2. No serial console until MMU is up.
    Because data cache maintenance is required until the MMU setup the
    early/debug serial console is not implemented. Therefore, we do not have
-   usual prints like U-boot’s banner etc. until the serial driver is
+   usual prints like U-Boot’s banner etc. until the serial driver is
    initialized.
 
 3. Single RAM bank supported.
    If a Xen guest is given much memory it is possible that Xen allocates two
    memory banks for it. The first one is allocated under 4GB address space and
    in some cases may represent the whole guest’s memory. It is assumed that
-   U-boot most likely won’t require high memory bank for its work andlaunching
+   U-Boot most likely won’t require high memory bank for its work andlaunching
    OS, so it is enough to take the first one.
 
 
diff --git a/doc/develop/driver-model/bind.rst b/doc/develop/driver-model/bind.rst
index b19661b5fe2d..0d0d40734c9d 100644
--- a/doc/develop/driver-model/bind.rst
+++ b/doc/develop/driver-model/bind.rst
@@ -7,7 +7,7 @@ Binding/unbinding a driver
 This document aims to describe the bind and unbind commands.
 
 For debugging purpose, it should be useful to bind or unbind a driver from
-the U-boot command line.
+the U-Boot command line.
 
 The unbind command calls the remove device driver callback and unbind the
 device from its driver.
diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/fs_firmware_loader.rst
index b0823700a90b..149b8b436ec3 100644
--- a/doc/develop/driver-model/fs_firmware_loader.rst
+++ b/doc/develop/driver-model/fs_firmware_loader.rst
@@ -92,9 +92,9 @@ For example of getting DT phandle from /chosen and creating instance:
 	if (ret)
 		return ret;
 
-Firmware loader driver is also designed to support U-boot environment
+Firmware loader driver is also designed to support U-Boot environment
 variables, so all these data from FDT can be overwritten
-through the U-boot environment variable during run time.
+through the U-Boot environment variable during run time.
 
 For examples:
 
@@ -110,7 +110,7 @@ fw_ubi_volume:
 When above environment variables are set, environment values would be
 used instead of data from FDT.
 The benefit of this design allows user to change storage attribute data
-at run time through U-boot console and saving the setting as default
+at run time through U-Boot console and saving the setting as default
 environment values in the storage for the next power cycle, so no
 compilation is required for both driver and FDT.
 
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index ffe25ca23185..ef0987c355c8 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -330,7 +330,7 @@ bit in OsIndications variable with
 
     => setenv -e -nv -bs -rt -v OsIndications =0x0000000000000004
 
-Since U-boot doesn't currently support SetVariable at runtime, its value
+Since U-Boot doesn't currently support SetVariable at runtime, its value
 won't be taken over across the reboot. If this is the case, you can skip
 this feature check with the Kconfig option (CONFIG_EFI_IGNORE_OSINDICATIONS)
 set.
diff --git a/doc/usage/cmd/source.rst b/doc/usage/cmd/source.rst
index 61a450590966..a5c5204a28b8 100644
--- a/doc/usage/cmd/source.rst
+++ b/doc/usage/cmd/source.rst
@@ -161,7 +161,7 @@ The boot scripts (boot.scr) is created with:
 
     mkimage -T script -n 'Test script' -d boot.txt boot.scr
 
-The script can be execute in U-boot like this:
+The script can be execute in U-Boot like this:
 
 .. code-block::
 
diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
index ed47ff561e30..68cacbbef669 100644
--- a/doc/usage/dfu.rst
+++ b/doc/usage/dfu.rst
@@ -9,7 +9,7 @@ Overview
 The Device Firmware Upgrade (DFU) allows to download and upload firmware
 to/from U-Boot connected over USB.
 
-U-boot follows the Universal Serial Bus Device Class Specification for
+U-Boot follows the Universal Serial Bus Device Class Specification for
 Device Firmware Upgrade Version 1.1 the USB forum (DFU v1.1 in www.usb.org).
 
 U-Boot implements this DFU capability (CONFIG_DFU) with the command dfu
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 184d426d0b3c..017f25f7a5a3 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -184,7 +184,7 @@ struct clk *clk_hw_register_mux_table(struct device *dev, const char *name,
 	if (!mux)
 		return ERR_PTR(-ENOMEM);
 
-	/* U-boot specific assignments */
+	/* U-Boot specific assignments */
 	mux->parent_names = parent_names;
 	mux->num_parents = num_parents;
 
diff --git a/drivers/gpio/gpio-fxl6408.c b/drivers/gpio/gpio-fxl6408.c
index 902da050fbf9..ca7aa14eeb23 100644
--- a/drivers/gpio/gpio-fxl6408.c
+++ b/drivers/gpio/gpio-fxl6408.c
@@ -27,7 +27,7 @@
  *   https://patchwork.kernel.org/patch/9148419/
  * - the Toradex version by Max Krummenacher <max.krummenacher@toradex.com>:
  *   http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/gpio/gpio-fxl6408.c?h=toradex_5.4-2.3.x-imx
- * - the U-boot PCA953x driver by Peng Fan <van.freenix@gmail.com>:
+ * - the U-Boot PCA953x driver by Peng Fan <van.freenix@gmail.com>:
  *   drivers/gpio/pca953x_gpio.c
  *
  * TODO:
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index d115fcf841ff..d624589a892b 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -553,7 +553,7 @@ config NAND_ZYNQ_USE_BOOTLOADER1_TIMINGS
 	bool "Enable use of 1st stage bootloader timing for NAND"
 	depends on NAND_ZYNQ
 	help
-	  This flag prevent U-boot reconfigure NAND flash controller and reuse
+	  This flag prevent U-Boot reconfigure NAND flash controller and reuse
 	  the NAND timing from 1st stage bootloader.
 
 config NAND_OCTEONTX
@@ -732,10 +732,10 @@ config SYS_NAND_BAD_BLOCK_POS
 	default 5 if HAS_NAND_SMALL_BADBLOCK_POS
 
 config SYS_NAND_U_BOOT_LOCATIONS
-	bool "Define U-boot binaries locations in NAND"
+	bool "Define U-Boot binaries locations in NAND"
 	help
 	Enable CONFIG_SYS_NAND_U_BOOT_OFFS though Kconfig.
-	This option should not be enabled when compiling U-boot for boards
+	This option should not be enabled when compiling U-Boot for boards
 	defining CONFIG_SYS_NAND_U_BOOT_OFFS in their include/configs/<board>.h
 	file.
 
diff --git a/drivers/mtd/nand/raw/fsl_ifc_spl.c b/drivers/mtd/nand/raw/fsl_ifc_spl.c
index 60a865b56673..c67065eaf8ca 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_spl.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_spl.c
@@ -275,8 +275,8 @@ void nand_boot(void)
 
 #ifdef CONFIG_CHAIN_OF_TRUST
 	/*
-	 * U-Boot header is appended at end of U-boot image, so
-	 * calculate U-boot header address using U-boot header size.
+	 * U-Boot header is appended at end of U-Boot image, so
+	 * calculate U-Boot header address using U-Boot header size.
 	 */
 #define FSL_U_BOOT_HDR_ADDR \
 		((CFG_SYS_NAND_U_BOOT_START + \
diff --git a/drivers/net/pfe_eth/pfe_hw.c b/drivers/net/pfe_eth/pfe_hw.c
index 4db6f3158c39..9f2f92d116dd 100644
--- a/drivers/net/pfe_eth/pfe_hw.c
+++ b/drivers/net/pfe_eth/pfe_hw.c
@@ -814,7 +814,7 @@ static inline void class_set_config(struct class_cfg *cfg)
 	writel(0x1, CLASS_AXI_CTRL);
 
 	/*Make Util AXI transactions non-bufferable */
-	/*Util is disabled in U-boot, do it from here */
+	/*Util is disabled in U-Boot, do it from here */
 	writel(0x1, UTIL_AXI_CTRL);
 }
 
diff --git a/drivers/phy/marvell/comphy_cp110.c b/drivers/phy/marvell/comphy_cp110.c
index e063b51c6dd9..a7e0099045ff 100644
--- a/drivers/phy/marvell/comphy_cp110.c
+++ b/drivers/phy/marvell/comphy_cp110.c
@@ -25,7 +25,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define MV_SIP_COMPHY_PLL_LOCK	0x82000003
 #define MV_SIP_COMPHY_XFI_TRAIN	0x82000004
 
-/* Used to distinguish between different possible callers (U-boot/Linux) */
+/* Used to distinguish between different possible callers (U-Boot/Linux) */
 #define COMPHY_CALLER_UBOOT			(0x1 << 21)
 
 #define COMPHY_FW_MODE_FORMAT(mode)		((mode) << 12)
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 7b64532e50b2..572cef1694c8 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -9,7 +9,7 @@
  * Author: Robert Marko <robert.marko@sartura.hr>
  * Author: Luka Kovacic <luka.kovacic@sartura.hr>
  *
- * Based on stock U-boot and Linux drivers
+ * Based on stock U-Boot and Linux drivers
  */
 
 #include <asm/gpio.h>
diff --git a/dts/Kconfig b/dts/Kconfig
index 3b7489f0f872..9152f5885e9a 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -171,7 +171,7 @@ config OF_LIST
 	default DEFAULT_DEVICE_TREE
 	help
 	  This option specifies a list of device tree files to use for DT
-	  control. These will be packaged into a FIT. At run-time, U-boot
+	  control. These will be packaged into a FIT. At run-time, U-Boot
 	  or SPL will select the correct DT to use by examining the
 	  hardware (e.g. reading a board ID value). This is a list of
 	  device tree files (without the directory or .dtb suffix)
@@ -254,7 +254,7 @@ config DTB_RESELECT
 config MULTI_DTB_FIT
 	bool "Support embedding several DTBs in a FIT image for u-boot"
 	help
-	  This option provides hooks to allow U-boot to parse an
+	  This option provides hooks to allow U-Boot to parse an
 	  appended FIT image and enable board specific code to then select
 	  the correct DTB to be used. Use this if you need to support
 	  multiple DTBs but don't use the SPL.
diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
index 9cf8a10c76c5..02173dea5f48 100644
--- a/fs/btrfs/compat.h
+++ b/fs/btrfs/compat.h
@@ -46,7 +46,7 @@
 /*
  * Read data from device specified by @desc and @part
  *
- * U-boot equivalent of pread().
+ * U-Boot equivalent of pread().
  *
  * Return the bytes of data read.
  * Return <0 for error.
diff --git a/fs/btrfs/extent-io.h b/fs/btrfs/extent-io.h
index 6b0c87da969d..5c5c579d1eaf 100644
--- a/fs/btrfs/extent-io.h
+++ b/fs/btrfs/extent-io.h
@@ -8,7 +8,7 @@
  *   Use pointer to provide better alignment.
  * - Remove max_cache_size related interfaces
  *   Includes free_extent_buffer_nocache()
- *   As we don't cache eb in U-boot.
+ *   As we don't cache eb in U-Boot.
  * - Include headers
  *
  * Write related functions are kept as we still need to modify dummy extent
diff --git a/include/fsl_validate.h b/include/fsl_validate.h
index fbcbd4249677..66a5883f1f7e 100644
--- a/include/fsl_validate.h
+++ b/include/fsl_validate.h
@@ -275,9 +275,9 @@ int fsl_check_boot_mode_secure(void);
 int fsl_setenv_chain_of_trust(void);
 
 /*
- * This function is used to validate the main U-boot binary from
+ * This function is used to validate the main U-Boot binary from
  * SPL just before passing control to it using QorIQ Trust
- * Architecture header (appended to U-boot image).
+ * Architecture header (appended to U-Boot image).
  */
 void spl_validate_uboot(uint32_t hdr_addr, uintptr_t img_addr);
 
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index f7a4a39d350b..1192d5902dc7 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -35,7 +35,7 @@ enum pm_api_id {
 	PM_FPGA_LOAD = 22,
 	PM_FPGA_GET_STATUS = 23,
 	PM_GET_CHIPID = 24,
-	/* ID 25 is been used by U-boot to process secure boot images */
+	/* ID 25 is been used by U-Boot to process secure boot images */
 	/* Secure library generic API functions */
 	PM_SECURE_SHA = 26,
 	PM_SECURE_RSA = 27,
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index bc5c5b558215..238b48c90fa9 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -5,7 +5,7 @@
 # Android Verified Boot 2.0 Test
 
 """
-This tests Android Verified Boot 2.0 support in U-boot:
+This tests Android Verified Boot 2.0 support in U-Boot:
 
 For additional details about how to build proper vbmeta partition
 check doc/android/avb2.rst
diff --git a/test/py/tests/test_cat/conftest.py b/test/py/tests/test_cat/conftest.py
index 058fe5235214..fc396f50d326 100644
--- a/test/py/tests/test_cat/conftest.py
+++ b/test/py/tests/test_cat/conftest.py
@@ -13,7 +13,7 @@ def cat_data(u_boot_config):
     """Set up a file system to be used in cat tests
 
     Args:
-        u_boot_config -- U-boot configuration.
+        u_boot_config -- U-Boot configuration.
     """
     mnt_point = u_boot_config.persistent_data_dir + '/test_cat'
     image_path = u_boot_config.persistent_data_dir + '/cat.img'
diff --git a/test/py/tests/test_efi_bootmgr/conftest.py b/test/py/tests/test_efi_bootmgr/conftest.py
index eabafa542987..0eca025058ee 100644
--- a/test/py/tests/test_efi_bootmgr/conftest.py
+++ b/test/py/tests/test_efi_bootmgr/conftest.py
@@ -12,7 +12,7 @@ def efi_bootmgr_data(u_boot_config):
     """Set up a file system to be used in UEFI bootmanager tests.
 
     Args:
-        u_boot_config -- U-boot configuration.
+        u_boot_config -- U-Boot configuration.
 
     Return:
         A path to disk image to be used for testing
diff --git a/test/py/tests/test_efi_capsule/conftest.py b/test/py/tests/test_efi_capsule/conftest.py
index a337e6293625..3e585b6c3d28 100644
--- a/test/py/tests/test_efi_capsule/conftest.py
+++ b/test/py/tests/test_efi_capsule/conftest.py
@@ -17,7 +17,7 @@ def efi_capsule_data(request, u_boot_config):
     for testing.
 
     request -- Pytest request object.
-    u_boot_config -- U-boot configuration.
+    u_boot_config -- U-Boot configuration.
     """
     mnt_point = u_boot_config.persistent_data_dir + '/test_efi_capsule'
     data_dir = mnt_point + CAPSULE_DATA_DIR
diff --git a/test/py/tests/test_efi_secboot/conftest.py b/test/py/tests/test_efi_secboot/conftest.py
index 30ff70294380..ff7ac7c81016 100644
--- a/test/py/tests/test_efi_secboot/conftest.py
+++ b/test/py/tests/test_efi_secboot/conftest.py
@@ -14,7 +14,7 @@ def efi_boot_env(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-        u_boot_config: U-boot configuration.
+        u_boot_config: U-Boot configuration.
 
     Return:
         A path to disk image to be used for testing
@@ -139,7 +139,7 @@ def efi_boot_env_intca(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-        u_boot_config: U-boot configuration.
+        u_boot_config: U-Boot configuration.
 
     Return:
         A path to disk image to be used for testing
diff --git a/test/py/tests/test_eficonfig/conftest.py b/test/py/tests/test_eficonfig/conftest.py
index f289df036260..0a82fbefd752 100644
--- a/test/py/tests/test_eficonfig/conftest.py
+++ b/test/py/tests/test_eficonfig/conftest.py
@@ -14,7 +14,7 @@ def efi_eficonfig_data(u_boot_config):
        tests
 
     Args:
-        u_boot_config -- U-boot configuration.
+        u_boot_config -- U-Boot configuration.
 
     Return:
         A path to disk image to be used for testing
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 9329ec6f1b2d..0d87d180c7b6 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -97,7 +97,7 @@ def pytest_generate_tests(metafunc):
 # Helper functions
 #
 def fstype_to_ubname(fs_type):
-    """Convert a file system type to an U-boot specific string
+    """Convert a file system type to an U-Boot specific string
 
     A generated string can be used as part of file system related commands
     or a config name in u-boot. Currently fat16 and fat32 are handled
@@ -217,7 +217,7 @@ def fs_obj_basic(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-	u_boot_config: U-boot configuration.
+	u_boot_config: U-Boot configuration.
 
     Return:
         A fixture for basic fs test, i.e. a triplet of file system type,
@@ -339,7 +339,7 @@ def fs_obj_ext(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-	u_boot_config: U-boot configuration.
+	u_boot_config: U-Boot configuration.
 
     Return:
         A fixture for extended fs test, i.e. a triplet of file system type,
@@ -440,7 +440,7 @@ def fs_obj_mkdir(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-	u_boot_config: U-boot configuration.
+	u_boot_config: U-Boot configuration.
 
     Return:
         A fixture for mkdir test, i.e. a duplet of file system type and
@@ -471,7 +471,7 @@ def fs_obj_unlink(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-	u_boot_config: U-boot configuration.
+	u_boot_config: U-Boot configuration.
 
     Return:
         A fixture for unlink test, i.e. a duplet of file system type and
@@ -551,7 +551,7 @@ def fs_obj_symlink(request, u_boot_config):
 
     Args:
         request: Pytest request object.
-        u_boot_config: U-boot configuration.
+        u_boot_config: U-Boot configuration.
 
     Return:
         A fixture for basic fs test, i.e. a triplet of file system type,
diff --git a/test/py/tests/test_scp03.py b/test/py/tests/test_scp03.py
index 1f689252ddf2..1a104b365f76 100644
--- a/test/py/tests/test_scp03.py
+++ b/test/py/tests/test_scp03.py
@@ -5,7 +5,7 @@
 # SCP03 command test
 
 """
-This tests SCP03 command in U-boot.
+This tests SCP03 command in U-Boot.
 
 For additional details check doc/usage/scp03.rst
 """
diff --git a/test/py/tests/test_xxd/conftest.py b/test/py/tests/test_xxd/conftest.py
index 59285aadf40d..f35b8f111362 100644
--- a/test/py/tests/test_xxd/conftest.py
+++ b/test/py/tests/test_xxd/conftest.py
@@ -13,7 +13,7 @@ def xxd_data(u_boot_config):
     """Set up a file system to be used in xxd tests
 
     Args:
-        u_boot_config -- U-boot configuration.
+        u_boot_config -- U-Boot configuration.
     """
     mnt_point = u_boot_config.persistent_data_dir + '/test_xxd'
     image_path = u_boot_config.persistent_data_dir + '/xxd.img'
-- 
2.36.1

