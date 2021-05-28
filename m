Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1086539443B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhE1Oeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 May 2021 10:34:50 -0400
Received: from mtaextp1.scidom.de ([146.107.3.202]:38090 "EHLO
        mtaextp1.scidom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhE1Oeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 May 2021 10:34:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id B92BC1800C11D;
        Fri, 28 May 2021 16:32:53 +0200 (CEST)
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FyjAP7Pn0oMy; Fri, 28 May 2021 16:32:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaextp1.scidom.de (Postfix) with ESMTP id 85B551800C12E;
        Fri, 28 May 2021 16:32:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaextp1.scidom.de 85B551800C12E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622212373; bh=z4m9OGbB3Cid7zLz/am7AEb0vOSMJg477e+71gfmf1g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=koI1Vta1KhlVLTc1/7m0C4WD26EXT4CvrWxQFvYlE7XXyBUhCYVf5S2D8iWgb1Kbv
         50T2hJiP+azoQl4rY1Eax3zW8kx8488vtb9cy+IkaoFPhF/9f5ktP0W/8fIMzWVB2h
         v3mzJAp6/SG1aWrNDOfv6Cf7wsp6Sv9f8ix7pYAj+wILrPZW/04eFSOOiphTUIi5GD
         lHzRjj6o4pkGLdid7Z7w4Y6p+h8XN6V4LGpycgzR6ePIJSSVAiaCHVVTL1wU7o31n1
         qnfeJn5NS5dIJFuARDAvHJk71pBE04HzaE/Q2PM+ZixoiKoe7/pN8Sz69ZV3scHACt
         zvumePWF1/czA==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaextp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaextp1.scidom.de
Received: from mtaextp1.scidom.de ([127.0.0.1])
        by localhost (mtaextp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xd736J6IFZ6D; Fri, 28 May 2021 16:32:53 +0200 (CEST)
Received: from mtaintp1.scidom.de (mtaintp1.scidom.de [146.107.8.197])
        by mtaextp1.scidom.de (Postfix) with ESMTPS id 5C7381800C11D;
        Fri, 28 May 2021 16:32:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 60CA6823B31D;
        Fri, 28 May 2021 16:33:09 +0200 (CEST)
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UEmuEQ4C9TAu; Fri, 28 May 2021 16:33:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 3977E8252E14;
        Fri, 28 May 2021 16:33:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mtaintp1.scidom.de 3977E8252E14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=helmholtz-muenchen.de; s=C0F30F38-B250-11EB-A191-7CCD3589A052;
        t=1622212389; bh=z4m9OGbB3Cid7zLz/am7AEb0vOSMJg477e+71gfmf1g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RtLRGmLFBYCkMBhkQhEWk1VbxPl8OJt7iqXUnN3lQv+opaEvlFJ0fKU7VWFclTvYY
         2OmqhOsVmEScvbOQxUZ73F1UkCpv4z+AW+qsiAVbQ/F/dZe8IKxd6tf4dn6I6ZnXP0
         jQXynPYuBLGKPT5+mBZJbQXxteDFLjMVq6QbOcOfFFMkyhR4IKQQrmnw4FgM3lKz3q
         3Kjov3PvXwf18xBaGqDfHm8BqUyCyZPoP5E4SMuvkcdjobhDHMn3+GVhQcIIAXwa1e
         XleTRypZJlOLAcddf824JL5I6nHDjaCdHXax48web0Fuij8WdmfTISCb5N2LKSf113
         3GcLura91Emog==
X-Amavis-Modified: Mail body modified (using disclaimer) - mtaintp1.scidom.de
X-Virus-Scanned: amavisd-new at mtaintp1.scidom.de
Received: from mtaintp1.scidom.de ([127.0.0.1])
        by localhost (mtaintp1.scidom.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U7EjcS6nBYQH; Fri, 28 May 2021 16:33:09 +0200 (CEST)
Received: from mbxp1.scidom.de (mbxp1.scidom.de [146.107.8.207])
        by mtaintp1.scidom.de (Postfix) with ESMTP id 181EC823B31D;
        Fri, 28 May 2021 16:33:09 +0200 (CEST)
Date:   Fri, 28 May 2021 16:33:08 +0200 (CEST)
From:   "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de> <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; 
        boundary="----=_Part_84421856_2082672536.1622212389003"
X-Originating-IP: [146.107.25.174]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: CeaBiQ80bF0+wGVeWNqLApR0Imkveg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_84421856_2082672536.1622212389003
Date: Fri, 28 May 2021 16:33:08 +0200 (CEST)
From: "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
To: Remi Gauvin <remi@georgianit.com>
Cc: Btrfs ML <linux-btrfs@vger.kernel.org>
Message-ID: <1108499927.84421836.1622212388508.JavaMail.zimbra@helmholtz-muenchen.de>
In-Reply-To: <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com>
References: <2106576727.79893362.1622034311642.JavaMail.zimbra@helmholtz-muenchen.de> <97e08f6c-1177-49f8-a05b-5f2917a77fb2@georgianit.com> <1608188083.80084937.1622040829715.JavaMail.zimbra@helmholtz-muenchen.de> <ab2bb27e-035f-d215-0e2d-c3c22101a06a@georgianit.com> <1204827780.82945725.1622144255373.JavaMail.zimbra@helmholtz-muenchen.de> <331cf8f6-b048-5b55-475f-5b3c460df400@georgianit.com>
Subject: Re: how to rollback / to a snapshot ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [146.107.25.174]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - GC90 (Win)/8.8.15_GA_4007)
Thread-Topic: how to rollback / to a snapshot ?
Thread-Index: CeaBiQ80bF0+wGVeWNqLApR0Imkveg==



----- On May 27, 2021, at 10:41 PM, Remi Gauvin remi@georgianit.com wrote:

> On 2021-05-27 3:37 p.m., Lentes, Bernd wrote:
> 
>> 
>> i followed your guide and tried a reboot remotely.
>> PC stuck in BIOS, someone in the office pressed F2, and system booted
>> completely.
>> But unfortunately in the bad system and without X:
>> 
>> root@pc65472:~# mount|grep btrfs
>> /dev/mapper/vg1-lv_root on / type btrfs
>> (rw,relatime,ssd,space_cache,subvolid=257,subvol=/@_bad)
> 
> This is interesting, because your system is mounting the old subvolume
> as root and not the new @.
> 
> Check the /etc/fstab, (maybe it would be wise to post it here.).  Maybe
> at some point, someone replaced the default 'subvolume=@' with a
> subvolid=257?

root@pc65472:~# less /etc/fstab
 ...
/dev/mapper/vg1-lv_root /               btrfs   defaults,subvol=@ 0       1
/dev/mapper/vg1-lv_root /home           btrfs   defaults,subvol=@home 0       2
/dev/sdb1               /data           btrfs   defaults,subvol=@data 0       2
UUID=68dc5e68-fc44-4163-bd75-537adf9f1266 /local          btrfs   defaults        0       0

seems to be ok

> 
> If that's the case, you should also check the /boot/grub/grub.cfg and
> verify that the kernel boot options specify: rootflags=subvol=@

root@pc65472:~# grep -i '@_bad' /boot/grub/grub.cfg
    font="/@_bad/usr/share/grub/unicode.pf2"
        linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro rootflags=subvol=@_bad  splash=verbose   <=== !!!!
                linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro rootflags=subvol=@_bad  splash=verbose   <=== !!!
                linux   /vmlinuz-4.4.0-66-generic root=/dev/mapper/vg1-lv_root ro recovery nomodeset dis_ucode_ldr rootflags=subvol=@_bad

I'm hesitating to manipulate grub.cfg directly, because of:

#
# DO NOT EDIT THIS FILE
#
# It is automatically generated by grub-mkconfig using templates
# from /etc/grub.d and settings from /etc/default/grub
#


interesting:
root@pc65472:/etc/grub.d# grep -i rootflags /etc/grub.d/*
/etc/grub.d/10_linux:       GRUB_CMDLINE_LINUX="rootflags=subvol=${rootsubvol} ${GRUB_CMDLINE_LINUX}"    <=== the culprit ?


/etc/grub.d/10_linux:
 ...
case x"$GRUB_FS" in
    xbtrfs)
        rootsubvol="`make_system_path_relative_to_its_root /`"
        rootsubvol="${rootsubvol#/}"
        if [ "x${rootsubvol}" != x ]; then
            GRUB_CMDLINE_LINUX="rootflags=subvol=${rootsubvol} ${GRUB_CMDLINE_LINUX}"
        fi;;
 ...

grub-mkconfig_lib: (is sourced in /etc/grub.d/10_linux)
make_system_path_relative_to_its_root ()
{
  "${grub_mkrelpath}" "$1"
}

if test "x$grub_mkrelpath" = x; then
  grub_mkrelpath="${bindir}/grub-mkrelpath"
fi

There is a binary "grub-mkrelpath":

root@pc65472:~# which grub-mkrelpath
/usr/bin/grub-mkrelpath
root@pc65472:~# grub-mkrelpath -?
Usage: grub-mkrelpath [OPTION...] PATH
Transform a system filename into GRUB one.

  -?, --help                 give this help list
      --usage                give a short usage message
  -V, --version              print program version

root@pc65472:~#
root@pc65472:~# grub-mkrelpath /
/@_bad  <=== !!!

grub-mkrelpath gives @_bad back, that's the problem. What can i do ?

> That doesn't really explain why X wouldn't be working.,,, or why
> pressing F2 did anything,, (that would indicated the Bios is
> experiencing some kind of error?)

Problem with the BIOS existed already. Problem with X is not severe.
Important is to rollback to the snapshot.

Bernd
------=_Part_84421856_2082672536.1622212389003
Content-Type: application/pkcs7-signature; name=smime.p7s; smime-type=signed-data
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCAMIIF
yDCCBLCgAwIBAgIMIgdroMAv99uEUtszMA0GCSqGSIb3DQEBCwUAMIGNMQswCQYDVQQGEwJERTFF
MEMGA1UECgw8VmVyZWluIHp1ciBGb2VyZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdz
bmV0emVzIGUuIFYuMRAwDgYDVQQLDAdERk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEdsb2Jh
bCBJc3N1aW5nIENBMB4XDTE5MTIwNDE3MzQwOVoXDTIyMTIwMzE3MzQwOVowVzELMAkGA1UEBhMC
REUxIzAhBgNVBAoMGkhlbG1ob2x0eiBaZW50cnVtIE11ZW5jaGVuMQwwCgYDVQQLDANJREcxFTAT
BgNVBAMMDEJlcm5kIExlbnRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALNyPs4s
Cm9YSSySI8e5wf9sOlO+957pJLdJ+jzo3iiFLNPt93ADP02C/MyWTxgnH98lsxMA20sd7H8bz/nN
6FsfEbOnSPjIN+1B/xif14NRqb2GwjKz1i13/zKDkmeerq6cmc5CJ2+/2MKhVP0raxJlDop5Vr5T
iXBRAmrrdriSJS2IqlcIQu9X+/4AcY6Q77LjIvM0T3vxxLF8Lx1vvcimoR8l8+RLaiPT0vonrpeA
o/BaxFBKReNFTYKfi4eQ0PmSLafSZ1Pmrh5yPungydMcI+B1eEpFYJT44wMLCYUI0Gzz/876UCXZ
2oF7KtyeKIuDBLQKnze4rFjxOEMOcq8CAwEAAaOCAlswggJXMD4GA1UdIAQ3MDUwDwYNKwYBBAGB
rSGCLAEBBDAQBg4rBgEEAYGtIYIsAQEEBDAQBg4rBgEEAYGtIYIsAgEEBDAJBgNVHRMEAjAAMA4G
A1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwHQYDVR0OBBYEFIbj
udERXYhU7DMaI17GPlWqLTQVMB8GA1UdIwQYMBaAFGs6mIv58lOJ2uCtsjIeCR/oqjt0MC0GA1Ud
EQQmMCSBImJlcm5kLmxlbnRlc0BoZWxtaG9sdHotbXVlbmNoZW4uZGUwgY0GA1UdHwSBhTCBgjA/
oD2gO4Y5aHR0cDovL2NkcDEucGNhLmRmbi5kZS9kZm4tY2EtZ2xvYmFsLWcyL3B1Yi9jcmwvY2Fj
cmwuY3JsMD+gPaA7hjlodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2Rmbi1jYS1nbG9iYWwtZzIvcHVi
L2NybC9jYWNybC5jcmwwgdsGCCsGAQUFBwEBBIHOMIHLMDMGCCsGAQUFBzABhidodHRwOi8vb2Nz
cC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwSQYIKwYBBQUHMAKGPWh0dHA6Ly9jZHAxLnBj
YS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwSQYIKwYBBQUH
MAKGPWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvZGZuLWNhLWdsb2JhbC1nMi9wdWIvY2FjZXJ0L2Nh
Y2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAG9FaTFBh6Yp8cNfWoaMF6GhZRFiARkPSNlvI8BJ
y+tS5W9urRKluF0mtgseNk1Eff3AD1bqicMIzThTuScwq1WhY5ZCGlD/qYLf+FY3VnPTjk6ZVruE
KuoA4bKJaVrXGkfBmw+oSMh6rfw6pwnchLXP7l40hDQ5tQ2/8BcpZYcykC4ziIga3hqe7vN4vhF6
gYKN6lET83QXYoh0IGCfFw3fIdTJk1IStMqe0Cd7eXpfwKQfjtzK8M5Qccj46923WGIwo0zSRiJR
R1J97qDZZxBsGJfj3tC5X/FkWhn3fDiPZYeTlvmFrzSyLSw/FBR/D2o/bUz+eaeVmenc32vxYmEA
ADGCApswggKXAgEBMIGeMIGNMQswCQYDVQQGEwJERTFFMEMGA1UECgw8VmVyZWluIHp1ciBGb2Vy
ZGVydW5nIGVpbmVzIERldXRzY2hlbiBGb3JzY2h1bmdzbmV0emVzIGUuIFYuMRAwDgYDVQQLDAdE
Rk4tUEtJMSUwIwYDVQQDDBxERk4tVmVyZWluIEdsb2JhbCBJc3N1aW5nIENBAgwiB2ugwC/324RS
2zMwDQYJYIZIAWUDBAIBBQCggc4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjEwNTI4MTQzMzA5WjAtBgkqhkiG9w0BCTQxIDAeMA0GCWCGSAFlAwQCAQUAoQ0GCSqG
SIb3DQEBCwUAMC8GCSqGSIb3DQEJBDEiBCBSLOobkKtKSx1vwnxNtny5oHwN/Rma26bGUxW6FJnF
GDA0BgkqhkiG9w0BCQ8xJzAlMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzAN
BgkqhkiG9w0BAQsFAASCAQBxdsOz7/bUK3VyXhQjDyoQL7zUWMeiASw3ftaM4K/rfyjhvMGsKRSg
aCwZKG7yV4jlIFwRXUEg/ujJu6V6F0BWhs9FJIh/ktx5Ik8awhZn6YTc2/Ot8Mgtqw/NjHIrvuOQ
aylyNzjVskJDfjN/QucE6/XP9b2yooXl5+11UpeTJKHkv8kCF+XdcpyqQsoapsjMozc43caPuRpV
iaYOYJ+4LQe9xVC/fKWAv+ahUYIcnSRRwDVjo+KZrUyNlSY5kLZVAbh/b1HFeoQZhNf8jx6oEWeN
21TA/xhN2upHMautxQsY6zQ1NwcaPppSJE4g1eYpqE843v+bNpGp6djQWbG3AAAAAAAA
------=_Part_84421856_2082672536.1622212389003--
