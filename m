Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD1669806
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 14:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbjAMNHB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 08:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241228AbjAMNGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 08:06:23 -0500
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Jan 2023 04:54:04 PST
Received: from mtaextp1.scidom.de (mtaextp1.scidom.de [146.107.3.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0253880
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 04:54:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id A7F3D217D49
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jIkDP505p8WU for <linux-btrfs@vger.kernel.org>;
        Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 7BDB823AF1D
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 13:44:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 7BDB823AF1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1673613849; bh=F2aoiWXVHY2o1Q5ZIQaaRUWpldfgCjz/tD3TQ+YXx40=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NBFBSrNeYJ72rrgyXZ827oGtENUd9ezfN5mwuKvCzzKCR0YJwcRc9SO3wm6TEzqUL
         PkhaDwjLSabao3H9K/G+9Qqhb2wT8hd4xZz5rzgt3cNeeITtKkmO0NGSD2HrnalaI9
         R2WoK6ZswE3KKxo6sBxvkRSXdPp5ZuQw6Pj7b+oujc2OsQkbxUs08ESXuYghEBKuwR
         26P9bjhhJR8/r00LqyUFHOMRfmk78mpKk22mpqOVKKQRAmtU1FIiEP47FhNPcIBaFQ
         0bLvO7EnIbPwr9q9VCu0ndA049fwRqE8tU9Xwp1vSo/jYV3ODs3RdUjOxPpriQUTvy
         DfQ2TpNuybcAg==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at 
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J_fo9JYXZvJn for <linux-btrfs@vger.kernel.org>;
        Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.15])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 58FC7217D52
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 5270515CBCF
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZLMZKsSmEb2n for <linux-btrfs@vger.kernel.org>;
        Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 2C8EE15CBD8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 13:44:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 2C8EE15CBD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1673613849; bh=FQ26fmocW/7iezpPlyT7y4crK+6e/rhczTKttvnK77E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KsEq+2pZdOrL8IdWb+8iHHZUusZUzWwi9PplaPez+a+v0jNNXxhlyhP3nB5zKWX6S
         Q3Y6zZR1XsR/OVU4OTnnTH+fU0k6EtR3OkjjNWzcKXNuu7CUTHlK+pRDuTW9UXlRgk
         ThBIBrPQ3yUgFzC9rpsF1+3l8uhjbmX5X4CgJY15bE+AeeXYVu5tJAoVuosaqHERTL
         uDouGK61cVvyjafJMDNM7m7aL4ucVBbprjaX9L/k31DInGObamCOx9WaIh6e1oOJKw
         Vn2DMnAXaf+dJtEnelqHw7U/XWWd61GvMQ54NayFHHrRtNxSa8egjCbDwAHowXY1Il
         M8OEsuq4B68MQ==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at 
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tJi_a8i8DZOY for <linux-btrfs@vger.kernel.org>;
        Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.7])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 13A8615CBCF
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 13:44:09 +0100 (CET)
Date:   Fri, 13 Jan 2023 13:44:08 +0100 (CET)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <368973486.82613591.1673613848596.JavaMail.zimbra@helmholtz-muenchen.de>
Subject: how to check commit of deletion of subvolumes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [146.107.3.8]
X-Mailer: Zimbra 8.8.15_GA_4464 (ZimbraWebClient - GC108 (Win)/8.8.15_GA_4468)
Thread-Index: Ps7+OEFS8kyzRlLecboje2bkxLv83g==
Thread-Topic: how to check commit of deletion of subvolumes
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

yesterday, about 20 hours ago, i deleted 9 snapshots from a BTRFS volume.
I know that the space is not available immediately, because BTRFS commits i=
n the background.
But currently, 20 hours later, i just have 1GB more space available.
Is there a way to check the commit of BTRFS ? To see if it's done or still =
running ?
I know about btrfs subvolume sync, but i am unsure about the syntax.

This is what i deleted:
  513  2023-01-12 17:37:05 btrfs sub delete /.snapshots/1/snapshot/
  514  2023-01-12 17:37:22 btrfs sub delete /.snapshots/2/snapshot/
  515  2023-01-12 17:37:39 btrfs sub delete /.snapshots/15/snapshot/
  519  2023-01-12 17:39:51 btrfs sub delete /.snapshots/16/snapshot/
  520  2023-01-12 17:39:57 btrfs sub delete /.snapshots/17/snapshot/
  521  2023-01-12 17:40:04 btrfs sub delete /.snapshots/18/snapshot/
  522  2023-01-12 17:40:10 btrfs sub delete /.snapshots/19/snapshot/
  523  2023-01-12 17:40:21 btrfs sub delete /.snapshots/20/snapshot/
  524  2023-01-12 17:40:30 btrfs sub delete /.snapshots/21/snapshot/
  525  2023-01-12 17:40:35 btrfs sub delete /.snapshots/22/snapshot/

When i now invoke a sync:
su084632:~ # btrfs subvolume sync /
su084632:~ # btrfs subvolume sync /.snapshots
su084632:~ # btrfs subvolume sync /.snapshots/
su084632:~ # btrfs subvolume sync /.snapshots/15/
su084632:~ #

the command is executed immediately and the prompt returns so too.

Does that mean the commit is done or do i missunderstood the syntax from sy=
nc ?

Bernd
--=20
Bernd Lentes=20
System Administrator=20
Institute for Metabolism and Cell Death (MCD)=20
Building 25 - office 122=20
HelmholtzZentrum M=C3=BCnchen=20
bernd.lentes@helmholtz-muenchen.de=20
phone: +49 89 3187 1241
       +49 89 3187 49123=20
fax:   +49 89 3187 2294=20
https://www.helmholtz-munich.de/en/mcd

Public key:=20
30 82 01 0a 02 82 01 01 00 b3 72 3e ce 2c 0a 6f 58 49 2c 92 23 c7 b9 c1 ff =
6c 3a 53 be f7 9e e9 24 b7 49 fa 3c e8 de 28 85 2c d3 ed f7 70 03 3f 4d 82 =
fc cc 96 4f 18 27 1f df 25 b3 13 00 db 4b 1d ec 7f 1b cf f9 cd e8 5b 1f 11 =
b3 a7 48 f8 c8 37 ed 41 ff 18 9f d7 83 51 a9 bd 86 c2 32 b3 d6 2d 77 ff 32 =
83 92 67 9e ae ae 9c 99 ce 42 27 6f bf d8 c2 a1 54 fd 2b 6b 12 65 0e 8a 79 =
56 be 53 89 70 51 02 6a eb 76 b8 92 25 2d 88 aa 57 08 42 ef 57 fb fe 00 71 =
8e 90 ef b2 e3 22 f3 34 4f 7b f1 c4 b1 7c 2f 1d 6f bd c8 a6 a1 1f 25 f3 e4 =
4b 6a 23 d3 d2 fa 27 ae 97 80 a3 f0 5a c4 50 4a 45 e3 45 4d 82 9f 8b 87 90 =
d0 f9 92 2d a7 d2 67 53 e6 ae 1e 72 3e e9 e0 c9 d3 1c 23 e0 75 78 4a 45 60 =
94 f8 e3 03 0b 09 85 08 d0 6c f3 ff ce fa 50 25 d9 da 81 7b 2a dc 9e 28 8b =
83 04 b4 0a 9f 37 b8 ac 58 f1 38 43 0e 72 af 02 03 01 00 01
(null)
Helmholtz Zentrum Muenchen Deutsches Forschungszentrum fuer Gesundheit und Umwelt (GmbH), Ingolstadter Landstr. 1, 85764 Neuherberg, www.helmholtz-munich.de. Geschaeftsfuehrung:  Prof. Dr. med. Dr. h.c. Matthias Tschoep, Kerstin Guenther, Daniela Sommer (kom.) | Aufsichtsratsvorsitzende: Prof. Dr. Veronika von Messling | Registergericht: Amtsgericht Muenchen  HRB 6466 | USt-IdNr. DE 129521671

