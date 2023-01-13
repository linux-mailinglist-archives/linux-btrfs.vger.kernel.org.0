Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152CD66990C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 14:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbjAMNvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 08:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241725AbjAMNuf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 08:50:35 -0500
Received: from mtaextp1.scidom.de (mtaextp1.scidom.de [146.107.3.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85853D5C5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 05:45:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 40F4F23F091;
        Fri, 13 Jan 2023 14:45:28 +0100 (CET)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gf0fQCs84FVT; Fri, 13 Jan 2023 14:45:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 12C0C23BCB8;
        Fri, 13 Jan 2023 14:45:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 12C0C23BCB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1673617528; bh=+GARoDbRC3LvnERcruf56dJ/Sbh2MuDIsJqNcUuRbiE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=HvbF/hYeIVh9n/hpCY42uTUXI25JVGeKGYBThcuX59+SP/JhFiLYVbiHhmRMVyBIV
         AKhXCurD8+NvffYUvy2CAlSRwLM5IGPvSp7ZIqZkmEhK2gRh3nI9vSnsdq0ss6LfyO
         1nbziGPItDBtu5RioipHnuprBY2lfqvCak6/pjQucfYOwCOf3XqjTDfKtuXV00LR6g
         yjkYaJJc0/eDqMeyL8EWl1frBjWdu1Z9wAGCJiWvL/fe8C1k+DVW3uJLZrG44/dHTO
         71NOdINhLRjhv5jVikqh5dbYpWH587FULN3dw7Xu5lihADqeUAol4LlAuuMXhijteV
         GQZfVGf0bEZUQ==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at 
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JiBsviB7RJYq; Fri, 13 Jan 2023 14:45:27 +0100 (CET)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.15])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id E3F98210350;
        Fri, 13 Jan 2023 14:45:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id DBEA915CA97;
        Fri, 13 Jan 2023 14:45:27 +0100 (CET)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q9xpBO6EHZOu; Fri, 13 Jan 2023 14:45:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id B461015CA98;
        Fri, 13 Jan 2023 14:45:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de B461015CA98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1673617527; bh=e5LkELVAn7q+y9xAp/e3FAv8ySD1XS8/UNFj6S5AwWg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=p37RU/JPs0eL+9oiHFBneEy4az7/YpOfjscBUCFMticyfVOaT3rDABBzlhxkkC6V9
         VREP3I5CSWfCEz+pMNcUUSnzshS3FJMUqxVbwXYjGRBpW16jxUxZivb4gx6MjDFfJ4
         7r/qwI3DcU1/IjA4f60aeQ6NLlBAmc9qaJIcnt2Wy3/Z2bH3AmFAquYe4DA6Ru6kqC
         01fGFyEfGBlfOp2eFozipJ261K6D9jwxNWI2tuwGav16sWBbIWrylP8iIli3q4nGJ+
         4SXQTBtzziPuywOD14l7nNem+2g8BUd9zLiA0s5bBy203FgzdyLvtnMUvTyGZyN+zl
         7kwLz2yM3n+UQ==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at 
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3OoMyMJxSAHb; Fri, 13 Jan 2023 14:45:27 +0100 (CET)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.7])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 950D815CA97;
        Fri, 13 Jan 2023 14:45:27 +0100 (CET)
Date:   Fri, 13 Jan 2023 14:45:27 +0100 (CET)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     dsterba@suse.cz
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1865119574.82683831.1673617527152.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <20230113131458.GU11562@twin.jikos.cz>
References: <368973486.82613591.1673613848596.JavaMail.zimbra@helmholtz-muenchen.de> <20230113131458.GU11562@twin.jikos.cz>
Subject: Re: how to check commit of deletion of subvolumes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.3.8]
X-Mailer: Zimbra 8.8.15_GA_4464 (ZimbraWebClient - GC108 (Win)/8.8.15_GA_4468)
Thread-Topic: how to check commit of deletion of subvolumes
Thread-Index: J/AC1GYalK+5b0SfQSj39wSqlc8MyQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

thanks for you help.

----- On 13 Jan, 2023, at 14:14, David Sterba dsterba@suse.cz wrote:
>> When i now invoke a sync:
>> su084632:~ # btrfs subvolume sync /
>> su084632:~ # btrfs subvolume sync /.snapshots
>> su084632:~ # btrfs subvolume sync /.snapshots/
>> su084632:~ # btrfs subvolume sync /.snapshots/15/
>> su084632:~ #
>> 
>> the command is executed immediately and the prompt returns so too.
>> 
>> Does that mean the commit is done or do i missunderstood the syntax from sync ?
> 
> The original path is lost once the subvolume is deleted so you need to
> compare the ids and cannot use the path for 'subvolume sync'.  You can
> check if the deleted subvolumes are listed in 'btrfs subvolume list -d'.

The -d is not mentioned in my man-pages, but in the help.
su084632:~ # btrfs sub list -d /
su084632:~ #
So there seem to be no more not yet cleaned subvolumes.
 
> If the 'subvolume sync' command returns it means there are no remaining
> subvolumes to clean, so by that I'd assume all the related data have
> been deleted.
> 
> If space is not reclaimed after deletion it's usually because there's
> some open file left. This applies to subvolumes too, so you may need to
> check 'lsof'.

Bernd
(null)
Helmholtz Zentrum Muenchen Deutsches Forschungszentrum fuer Gesundheit und Umwelt (GmbH), Ingolstadter Landstr. 1, 85764 Neuherberg, www.helmholtz-munich.de. Geschaeftsfuehrung:  Prof. Dr. med. Dr. h.c. Matthias Tschoep, Kerstin Guenther, Daniela Sommer (kom.) | Aufsichtsratsvorsitzende: Prof. Dr. Veronika von Messling | Registergericht: Amtsgericht Muenchen  HRB 6466 | USt-IdNr. DE 129521671

